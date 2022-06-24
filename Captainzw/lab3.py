from math import *

# 原被积函数
def f(x):
    return (2 * x - x ** 2 + x ** 3 + e ** (x / 2)) ** 0.5

# 复合辛普森函数
def S1(x, h=2):
    return h / 6 * (f(x) + 4 * f(x + h / 2) + f(x + h))


# 复合辛普森公式
def Simpson(esp):
    S0 = S1(0)
    n = 2
    h = 2 / n
    S = f(0) + f(2)
    for i in range(0, 2):
        S += 4 * f((i + 0.5) * h)
    for i in range(1, 2):
        S += 2 * f(i * h)
    S = S * h / 6
    while abs(S0 - S) / 15 > esp:
        n *= 2
        h = 2 / n
        S0 = S
        S = f(0) + f(2)
        for i in range(0, n):
            S += 4 * f((i + 0.5) * h)
        for i in range(1, n):
            S += 2 * f(i * h)
        S = S * h / 6
    print("复合辛普森公式的迭代次数为：", int(log(n, 2)))
    print("复合辛普森公式的步长为：", h)
    print("复合辛普森公式的迭代结果为：", S + (S - S0) / 15)

#复合梯形函数
def T1(x, h=2):
    return h / 2 * (f(x) + f(x + h))

# 复合梯形公式
def TAN(esp):
    T0 = T1(0)
    n = 2
    h = 2 / n
    T = f(0) + f(2)
    for i in range(0, 2):
        T += 2 * f(i * h)
    T = T * h / 2
    while abs(T - T0) / 3 > esp:
        n *= 2
        h = 2 / n
        T0 = T
        T = f(0) + f(2)
        for i in range(1, n):
            T += 2 * f(i * h)
        T = T * h / 2
    print("复合梯形的迭代次数为：", int(log(n, 2)))
    print("复合梯形公式的步长为：", h)
    print("复合梯形公式的迭代结果为：", T+(T-T0)/3)


esp=1e-5
TAN(esp)
Simpson(esp)
