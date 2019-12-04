import threading
import random
import numpy as np

flag = True


def request(i):
    hold = []
    for j in range(10):
        hold.append(random.randint(0, max[i][j]))
    return np.matrix(hold)


def release(i, req):
    avail += req + alloc[i]
    alloc.pop(i)


def safe(avail, need):
    for i in range(10):
        test = need[i] - avail[i]

def check(x, y):
    flag = True
    for i in range(10):
        if x[i] > y[i]:
            flag = False
            return False
    return True
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
    shadow = need.copy()
    test = avail - requested
    for i in test:
        if i < 0:
            print(preq + "requested " + requested " and failed")
    zf = True
    for i in test:
        if i != 0:
            zf = False
    if zf:
        release(preq, requested)

    shadow[preq] = shadow[preq] - requested
    safe(test, shadow)
