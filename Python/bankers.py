import threading
import random
import numpy as np


def request(max):
    hold = []
    for j in range(10):
        hold.append(random.randint(0, max[j]))
    return np.matrix(hold)


def release(i, avail, alloc, need):
    avail += alloc[i]
    need.pop(i)
    return np.delete(alloc, i, axis=0)


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
        alloc_shadow = release(i, avail_shadow, alloc, need_shadow)
        if safe(avail_shadow, need_shadow, alloc_shadow):
            return True
    return False


if __name__ == '__main__':
    flag = True
    res = []
    avail = [8, 8, 8, 8, 8, 8, 8, 8, 8, 8]
    # avail = [6, 6, 6, 6, 6, 6, 6, 6, 6, 6]
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

    print('resources are:')
    print(res)
    print('available resourcesr are:')
    print(avail)
    print('needs are:')
    print(need)
    print('allocated resources are:')
    print(alloc)

    # --------------------------------

    while flag:
        req_id = random.randint(0, len(alloc) - 1)
        requested = request(need[req_id])
        need_shadow = need.copy()
        avail_shadow = np.array(avail - requested)
        can = True
        for i in avail_shadow[0]:
            if i < 0:
                print("row " + str(req_id) + " requested " + str(
                    requested) + " and failed because requested resources were greater than available resources ")
                can = False
                break
        if not can:
            continue
        need_shadow[req_id] = np.array(need_shadow[req_id] - requested)[0]
        alloc_shadow = alloc.copy()
        alloc_shadow[req_id] = np.array(requested + alloc_shadow[req_id])[0]
        zf = True
        for i in need_shadow[req_id]:
            if i != 0:
                zf = False
                break
        if zf:
            print("row " + str(req_id) + " requested " + str(
                requested) + "and now is done.")
            alloc = alloc_shadow
            need = need_shadow
            avail = avail_shadow
            alloc = release(req_id, avail, alloc, need)
            print("allocates now are:")
            print(alloc)
            print("needs now are:")
            print(need)
            print("availables now are:")
            print(avail)
            if len(alloc) == 0:
                flag = False
            continue
        state = safe(avail_shadow[0], need_shadow, alloc_shadow)
        if not state:
            print("row " + str(req_id) + " requested " + str(
                requested) + " and deadlock happened so we skip the request")
        else:
            print("row " + str(req_id) + " requested " + str(requested) + " and we are in safe state")
            need = need_shadow
            avail = avail_shadow
            alloc = alloc_shadow
            print("availables now are:")
            print(avail)

    print("All are done without deadlock (now available resources are equal with resources)")
