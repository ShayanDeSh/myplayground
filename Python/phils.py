import threading


lock = threading.Lock()
chops = [threading.Semaphore(1), threading.Semaphore(1), threading.Semaphore(1),
         threading.Semaphore(1), threading.Semaphore(1)]


def think(phil):
    phil['state'] = 'thinking'
    print("phil " + str(phil['num']) + " is " + phil['state'])


def pick_chop(phil):
    i = phil['num']
    j = phil['num'] + 1
    if j == 5:
        j = 0
    lock.acquire()
    chops[i].acquire()
    chops[j].acquire()
    lock.release()
    phil['state'] = 'eating'
    print("phil " + str(phil['num']) + " is " + phil['state'])
    think(phil)
    chops[i].release()
    chops[j].release()


def set_state(phil):
    think(phil)
    pick_chop(phil)



def main():
    phils = []
    phil = {'state': 'none', 'num': 0, 'thread': None}
    t1 = threading.Thread(target=set_state, args=(phil,))
    phil['thread'] = t1
    phils.append(phil)
    phil = {'state': 'none', 'num': 1, 'thread': None}
    t2 = threading.Thread(target=set_state, args=(phil,))
    phil['thread'] = t2
    phils.append(phil)
    phil = {'state': 'none', 'num': 2, 'thread': None}
    t3 = threading.Thread(target=set_state, args=(phil,))
    phil['thread'] = t3
    phils.append(phil)
    phil = {'state': 'none', 'num': 3, 'thread': None}
    t4 = threading.Thread(target=set_state, args=(phil,))
    phil['thread'] = t4
    phils.append(phil)
    phil = {'state': 'none', 'num': 4, 'thread': None}
    t5 = threading.Thread(target=set_state, args=(phil,))
    phil['thread'] = t5
    phils.append(phil)
    phils[0]['thread'].start()
    phils[2]['thread'].start()
    phils[3]['thread'].start()
    phils[4]['thread'].start()
    phils[1]['thread'].start()

if __name__ == "__main__":
    main()