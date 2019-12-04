import threading
import random
import numpy as np


def request(max):
    hold = []
    for j in range(10):
        hold.append(random.randint(0, max[j]))
    return np.matrix(hold)


def release(i, req, avail, alloc, need):
    avail += req + alloc[i]
    need.pop(i)
    return np.delete(alloc, 0, axis=0)


def check(x, y):
    for i in range(10):
        if x[i] > y[i]:
            return False
    return True


def safe(avail, need, alloc):
    if len(need) == 0:
        return True
    for i in range(len(need)):
        flag = check(need[i], avail)
        if not flag:
            continue
        need_shadow = need.copy()
        # alloc_shadow = alloc.copy()
        avail_shadow = avail.copy()
        alloc_shadow = release(i, np.zeros([1, 10], dtype=np.int32)[0], avail_shadow, alloc, need_shadow)
        if safe(avail_shadow, need_shadow, alloc_shadow):
            return True
    return False


if __name__ == '__main__':
    flag = True
    res = []
    avail = [5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
    # avail = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
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

    maxMatrix = np.array(max)
    alloc = np.array(alloc)

    for i in range(10):
        need.append(maxMatrix[i] - alloc[i])
    hold = np.zeros([1, 10])
    # print(alloc)
    for i in range(10):
        hold += alloc[i]

    res = hold + avail
    print(res)
    while flag:
        preq = random.randint(0, len(alloc) - 1)
        requested = request(need[preq])
        need_shadow = need.copy()
        avail_shadow = np.array(avail - requested)
        for i in avail_shadow[0]:
            if i < 0:
                print("row " + str(preq) + " requested " + str(
                    requested) + " and failed because lack of available resource")
                continue
        need_shadow[preq] = np.array(need_shadow[preq] - requested)[0]
        zf = True
        for i in need_shadow[preq]:
            if i != 0:
                zf = False
                break
        if zf:
            print("row " + str(preq) + " requested " + str(
                requested) + "and now is done.")
            alloc = release(preq, requested, avail, alloc, need)
            print("allocates now are:")
            print(alloc)
            print("needs now are:")
            print(need)
            print("availables now are:")
            print(avail)
            if len(alloc) == 0:
                flag = False
            continue
        alloc_shadow = alloc.copy()
        alloc_shadow[preq] = np.array(requested + alloc_shadow[preq])[0]
        state = safe(avail_shadow[0], need_shadow, alloc_shadow)
        if not state:
            print("row " + str(preq) + " requested " + str(requested) + " and deadlock happened so we skip the request")
        else:
            print("row " + str(preq) + " requested " + str(requested) + " and we are in safe state")
            need = need_shadow
            avail = avail_shadow
            alloc = alloc_shadow
            print("availables now are:")
            print(avail)

    print("All are done without deadlock")
