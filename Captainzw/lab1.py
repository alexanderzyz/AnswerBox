from math import *


def f(x):
    return e ** x + 3 * x ** 3 - 2 * x ** 2 + log(x, e) - 1


def f2(x):
    return pow((1 - log(x, e) + 2 * x ** 2 - e ** x) / 3, 1 / 3)


# 二分法
def dichotomy(a0, a1, eps, M):
    times = 0
    while abs(a1 - a0) >= eps and times < M:
        temp = (a0 + a1) / 2
        if f(temp) > 0:
            a1 = temp
        else:
            a0 = temp
        times = times + 1
    if times >= M:
        print("二分法迭代超过{MAXTIME}次，计算失败".format(MAXTIME=M))
    else:
        print("二分法的迭代结果:", a1)
        print("二分法的迭代次数:", times)
        print("二分法结果的函数值:", f(a1))



# 迭代法
def iteration(a0, a1, eps, M):
    times = 1
    temp = (a0 + a1) / 2
    temp2 = f2(temp)
    while abs(temp2 - temp) >= eps and times < M:
        times = times + 1
        temp = temp2
        temp2 = f2(temp)
    if times >= M:
        print("迭代法迭代超过{MAXTIME}次，计算失败".format(MAXTIME=M))
    else:
        print("迭代法的迭代结果:", temp2)
        print("迭代法的迭代次数:", times)
        print("迭代法结果的函数值:", f(temp2))


# 艾特肯加速方法
def Aitken(a0, a1, eps, M):
    times = 1
    temp = (a0 + a1) / 2
    yk = f2(temp)
    zk = f2(yk)
    temp2 = temp - (yk - temp) ** 2 / (zk - 2 * yk + temp)
    while abs(temp2 - temp) >= eps and times < M:
        temp = temp2
        yk = f2(temp)
        zk = f2(yk)
        temp2 = temp - (yk - temp) ** 2 / (zk - 2 * yk + temp)
        times = times + 1
    if times >= M:
        print("迭代法迭代超过{MAXTIME}次，计算失败".format(MAXTIME=M))
    else:
        print("艾特肯加速法的迭代结果:", temp2)
        print("艾特肯加速法的迭代次数:", times)
        print("艾特肯加速法结果的函数值:", f(temp2))


eps = 10 ** -4
M = 40
a0 = 0
a1 = 1
dichotomy(a0, a1, eps, M)
iteration(a0, a1, eps, M)
Aitken(a0, a1, eps, M)
