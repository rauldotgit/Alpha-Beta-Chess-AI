import time

def speedCheck(func1, func2):
    f1_t0 = time.clock()
    func1()
    f1_t1 = time.clock() - f1_t0

    f2_t0 = time.clock()
    func2()
    f2_t1 = time.clock() - f2_t0

    time1 = f1_t1 - f1_t0
    time2 = f2_t1 - f2_t0
    
    return [time1, time2]