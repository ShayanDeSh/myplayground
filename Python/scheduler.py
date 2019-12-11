tasks = []


def fcfs(tasks):
    time = 0
    for i in range(len(tasks)):
        print('task ' + str(i) + ' waited for ' + str(time))
        time += tasks.pop(0)
    print('we are at time ' + str(time) + ' and all is finished')


def sjf(tasks):
    tasks.sort()
    fcfs(tasks)


def round_robin(q, tasks):
    time = 0
    n = len(tasks)
    while(n != 0):
        for i in range(len(tasks)):
            if tasks[i] <= q and tasks[i] > 0:
                print('task ' + str(i) + ' waited for ' + str(time))
                time += tasks[i]
                tasks[i] -= q
                n -= 1
            elif tasks[i] > 0:
                time += q
                tasks[i] -= q


def priority_sch(tasks):
    time = 0
    tasks.sort(key=sort_priority)
    print(tasks)
    for i in range(len(tasks)):
        print('task ' + str(i) + ' waited for ' + str(time))
        time += tasks.pop(0)['duration']
    print('we are at time ' + str(time) + ' and all is finished')


def sort_priority(task):
    return task['priority']


def main():
    option = input()
    option = int(option)
    print('Enter number of input')
    n = input()
    for i in range(int(n)):
        job = input()
        hold = job.split(" ")
        if len(hold) == 2:
            task = {'duration': int(hold[0]), 'priority': int(hold[1])}
            tasks.append(task)
        elif len(hold) == 1:
            task = int(hold[0])
            tasks.append(task)
    if option == 0:
        print('enter quantom: ')
        q = int(input())
        round_robin(2, tasks)
    if option == 1:
        sjf(tasks)
    if option == 2:
        fcfs(tasks)
    if option == 3:
        priority_sch(tasks)

if __name__ == "__main__":
    main()
