import queue
import threading
import run
import main2

counter = queue.Queue(1)


class Collecting(threading.Thread):
    def __init__(self, threadID, name):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name

    def run(self):
        print("开始线程：" + self.name)
        main2.driving(counter)


class Sending(threading.Thread):
    def __init__(self, threadID, name):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name

    def run(self):
        print("开始线程：" + self.name)
        run.send(counter)


# 创建新线程
thread1 = Collecting(1, "opencv")
thread2 = Sending(2, "aliyun")

# 开启新线程
thread1.start()
thread2.start()
