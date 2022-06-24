import threading
import ca2r
import time
import Yunrun
params=[0,52,27,1,2,0]
class Car(threading.Thread):
    def __init__(self, threadID):
        threading.Thread.__init__(self)
        self.id = threadID

    def run(self):
        ca2r.run(params)

class Aliyun(threading.Thread):
    def __init__(self, threadID):
        threading.Thread.__init__(self)
        self.id = threadID
    def run(self):
        Yunrun.send(params)

thread1=Car(1)
thread2=Aliyun(2)

thread1.start()
thread2.start()