import threading
import random
import numpy as np


def request(i):
    hold = []
    for j in range(10):
        hold.append(random.randint(0, max[i][j]))
    return np.matrix(hold)


def release(i, req, avail, alloc):
    avail += req + alloc[i]
    alloc.pop(i)


def check(x, y):
    for i in range(10):
        if x[i] > y[i]:
            flag = False
    return True


def safe(avail_shadow, shadow_need, alloc_shadow):
    for i in range(10):
        flag = check(shadow_need, avail_shadow)
        if not flag:
            continue
        release(i, np.zeros([1, 10]), avail_shadow, alloc_shadow)



if __name__ == '__main__':
    flag = True
    res = []
    avail = [5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
    max = []
    alloc = []
    need = []
    for i in range(10):
        hold = []
        for j in range(10):
            hold.append(random.randint(0, 10))
        max.append(hold)
    for i in range(10):
        hold = []
        for j in range(10):
            hold.append(random.randint(0, max[i][j]))
        alloc.append(hold)

    maxMatrix = np.matrix(max)
    allocMatrix = np.matrix(alloc)

    for i in range(10):
        need.append(maxMatrix[i] - allocMatrix[i])
    hold = np.zeros([1, 10])
    # print(alloc)
    for i in range(10):
        hold += alloc[i]

    res = hold + avail
    print(res)
    while flag:
        preq = random.randint(0, 10)
        requested = request(preq)
        need_shadow = need.copy()
        avail_shadow = avail - requested
        for i in avail_shadow:
            if i < 0:
                print(preq + " requested " + requested + " and failed because lack of available resource")
                continue
        zf = True
        for i in avail_shadow:
            if i != 0:
                zf = False
        if zf:
            print(preq + " is done")
            release(preq, requested, avail, alloc)
            continue
        need_shadow[preq] = need_shadow[preq] - requested
        alloc_shadow = alloc.copy()
        safe(avail_shadow, need_shadow, alloc_shadow)
