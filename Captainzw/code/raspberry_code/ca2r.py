#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# －－－－湖南创乐博智能科技有限公司－－－－
#  文件名：06_button.py
#  版本：V2.0
#  author: zhulin
# 说明：轻触按键实验
#####################################################

import RPi.GPIO as GPIO
import LCD1602
import time
import humiture

makerobo_RedPin = 13
makerobo_BtnPin = 20
makerobo_TouchPin = 25  # 触摸传感器管脚PIN
col = 2  # LED颜色标志位
buzzerPower = "stop"  # 蜂鸣器状态调节位
makerobo_R = 18  # 红色LEDPin端口
makerobo_G = 27  # 绿色LEDPin端口
makerobo_B = 22  # 蓝色LEDPin端口
carPower = False
# 初始化GPIO口
makerobo_Buzzer = 24
A = [0, 221, 248, 278, 294, 330, 371, 416,
     441, 495, 556, 589, 661, 742, 833,
     882, 990, 1112, 1178, 1322, 1484, 1665]
B = [0, 248, 278, 294, 330, 371, 416, 467,
     495, 556, 589, 661, 742, 833, 935,
     990, 1112, 1178, 1322, 1484, 1665, 1869]
C = [0, 131, 147, 165, 175, 196, 221, 248,
     262, 294, 330, 350, 393, 441, 495,
     525, 589, 661, 700, 786, 882, 990]
D = [0, 147, 165, 175, 196, 221, 248, 278,
     294, 330, 350, 393, 441, 495, 556,
     589, 661, 700, 786, 882, 990, 1112]
E = [0, 165, 175, 196, 221, 248, 278, 312,
     330, 350, 393, 441, 495, 556, 624,
     661, 700, 786, 882, 990, 1112, 1248]
F = [0, 175, 196, 221, 234, 262, 294, 330,
     350, 393, 441, 495, 556, 624, 661,
     700, 786, 882, 935, 1049, 1178, 1322]
G = [0, 196, 221, 234, 262, 294, 330, 371,
     393, 441, 495, 556, 624, 661, 742,
     786, 882, 935, 1049, 1178, 1322, 1484]
# 第一首歌谱子频率
song_1 = [12, 12, 19, 17, 15, 14, 13, 13, 18, 18, 17, 15, 16, 15, 15, 12, 12, 13, 12, 15, 14, 14, 12, 12, 13, 12, 15,
          14, 14, 12, 12, 19, 17, 15, 14, 13, 13, 18, 18, 17, 15, 16, 15, 15]
beat_1 = [1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 1,
          2, 2, 1, 1, 1, 1, 1]


def run(params):  # params=['carPower','humidity','temperature','buzzer_state','RGB_STATE','TIRED_DRIVE']
    def makerobo_setup(Rpin, Gpin, Bpin):
        GPIO.setmode(GPIO.BCM)  # 采用实际的物理管脚给GPIO口
        GPIO.setwarnings(False)  # 去除GPIO口警告
        global pins
        global p_R, p_G, p_B
        pins = {'pin_R': Rpin, 'pin_G': Gpin, 'pin_B': Bpin}
        for i in pins:
            GPIO.setup(pins[i], GPIO.OUT)  # 设置Pin模式为输出模式
            GPIO.output(pins[i], GPIO.LOW)  # 设置Pin管脚为低电平(0V)关闭LED

        # 由于RGB三色模块每一个LED达到一定的亮度，需要的电流值是不一样，所以设置的频率有区别
        p_R = GPIO.PWM(pins['pin_R'], 2000)  # 设置频率为2KHz
        p_G = GPIO.PWM(pins['pin_G'], 1999)
        p_B = GPIO.PWM(pins['pin_B'], 5000)

        # 初始化占空比为0(led关闭)
        p_R.start(0)
        p_G.start(0)
        p_B.start(0)
        # 初始化显示屏
        LCD1602.init(0x27, 1)  # init(slave address, background light)
        LCD1602.write(0, 0, 'Welcome to car')
        LCD1602.write(0, 1, 'mutimedia')
        GPIO.setup(makerobo_TouchPin, GPIO.IN, pull_up_down=GPIO.PUD_UP)  # 设置BtnPin管脚为输入模式，上拉至高电平(3.3V)
        GPIO.setup(makerobo_BtnPin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
        GPIO.add_event_detect(makerobo_BtnPin, GPIO.BOTH, callback=makerobo_detect, bouncetime=600)
        GPIO.add_event_detect(makerobo_TouchPin, GPIO.BOTH, callback=makerobo_Print, bouncetime=600)
        time.sleep(2)
        # 初始化蜂鸣器
        GPIO.setup(makerobo_RedPin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
        GPIO.add_event_detect(makerobo_RedPin, GPIO.BOTH, callback=makerobo_stop, bouncetime=600)
        GPIO.setup(makerobo_Buzzer, GPIO.OUT)  # Set pins' mode is output Buzzer = 11
        global Buzz  # Assign a global variable to replace GPIO.PWM
        Buzz = GPIO.PWM(makerobo_Buzzer, 440)  # 440 is initial frequency.440HZ初试频率

    def makerobo_pwm_map(x, in_min, in_max, out_min, out_max):
        return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min  # Start Buzzer pin with 50% duty ration

    def tone(a, c):
        if c == 'A':
            for i in range(len(a)):
                a[i] = A[a[i]]
        if c == 'B':
            for i in range(len(a)):
                a[i] = B[a[i]]
        if c == 'C':
            for i in range(len(a)):
                a[i] = C[a[i]]
        if c == 'D':
            for i in range(len(a)):
                a[i] = D[a[i]]
        if c == 'E':
            for i in range(len(a)):
                a[i] = E[a[i]]
        if c == 'F':
            for i in range(len(a)):
                a[i] = F[a[i]]
        if c == 'G':
            for i in range(len(a)):
                a[i] = G[a[i]]

    def makerobo_set_Color():  # 例如:col  = 0x112233
        R_val = 47
        G_val = 207
        B_val = 2.7
        R_val2 = 245
        G_val2 = 10
        B_val2 = 0
        R = 0
        G = 0
        B = 0
        # 把0-255的范围同比例缩小到0-100之间
        if col % 3 == 0:
            R = makerobo_pwm_map(R_val, 0, 255, 0, 100)
            G = makerobo_pwm_map(G_val, 0, 255, 0, 100)
            B = makerobo_pwm_map(B_val, 0, 255, 0, 100)
        if col % 3 == 1:
            R = makerobo_pwm_map(R_val2, 0, 255, 0, 100)
            G = makerobo_pwm_map(G_val2, 0, 255, 0, 100)
            B = makerobo_pwm_map(B_val2, 0, 255, 0, 100)
        if col % 3 == 2:
            R = 0
            G = 0
            B = 0
        p_R.ChangeDutyCycle(R)  # 改变占空比
        p_G.ChangeDutyCycle(G)  # 改变占空比
        p_B.ChangeDutyCycle(B)  # 改变占空比

    def makerobo_off():
        GPIO.setmode(GPIO.BOARD)  # 采用实际的物理管脚给GPIO口
        for i in pins:
            GPIO.setup(pins[i], GPIO.OUT)  # 设置Pin模式为输出模式
            GPIO.output(pins[i], GPIO.LOW)  # 设置Pin管脚为低电平(0V)关闭LED

    # 打印函数，显示出按键按下
    def makerobo_Print(chn):
        print("Blue Button clicked")
        global makerobo_tmp
        global col
        if carPower:
            col += 1
            print('*************************')
            print('* Makerobo Have a touch *')
            print('*************************')
            params[4] = col
        else:
            col = 2
            params[4] = col
        makerobo_set_Color()

    # 循环函数
    def makerobo_loop():
        global carPower
        global col
        global buzzerPower
        global Buzz
        tone(song_1, 'C')
        while True:
            params[0] = carPower
            params[4] = col
            params[3] = buzzerPower
            if carPower:
                Buzz.start(50)
                t = time.time()
                curr_time = time.localtime(t)
                asc_time = time.asctime(curr_time)
                asc_time = asc_time[0:16] + asc_time[-5:len(asc_time) + 1]
                tmp = asc_time + "     "
                LCD1602.clear()
                res = humiture.getres()
                params[1] = res[0]
                params[2] = res[1]
                print(res)
                LCD1602.write(0, 1, "T:" + str(res[1]) + "C" + " H:" + str(res[0]) + "%")
                for i in range(0, len(song_1)):
                    if not carPower:
                        LCD1602.clear()
                        time.sleep(1)
                        break
                    if buzzerPower!='stop':
                        if params[5] == 1:
                            Buzz.ChangeFrequency(1000)
                            buzzerPower = "warn"
                        else:
                            Buzz.ChangeFrequency(song_1[i])
                            buzzerPower = "music"
                    LCD1602.write(0, 0, tmp)
                    if params[5]==1:
                        LCD1602.write(0, 1, "T:" + str(res[1]) + "C" + " H:" + str(res[0]) + "%"+" Warn")
                    else:
                        LCD1602.write(0, 1, "T:" + str(res[1]) + "C" + " H:" + str(res[0]) + "%")
                    tmp = tmp[1:] + tmp[0]
                    params[3] = buzzerPower
                    time.sleep((60 / 100) / beat_1[i])
            else:
                LCD1602.clear()
                time.sleep(1)

    # 释放资源
    def makerobo_destroy():
        p_R.stop()  # 关闭红色PWM
        p_G.stop()  # 关闭绿色PWM
        p_B.stop()  # 关闭蓝色PWM
        LCD1602.clear()
        makerobo_off()  # 关闭RGB-LED灯
        GPIO.cleanup()  # 释放资源

    def makerobo_detect(chn):
        global carPower
        global col
        global Buzz
        Buzz.stop()
        print("Button detected")
        if carPower == False:
            carPower = True
            makerobo_stop(36)
        else:
            col = 2
            carPower = False
            makerobo_Print(36)
            makerobo_stop(36)

    def makerobo_stop(chn):
        global buzzerPower
        global Buzz
        print("red_btn")
        print(buzzerPower)
        if carPower:
            if buzzerPower == "warn" or buzzerPower == "music":
                buzzerPower = "stop"
                Buzz.stop()
            else:
                if params[5] == 1:
                    buzzerPower = "warn"
                else:
                    buzzerPower = "music"
                Buzz.start(50)
        params[3] = buzzerPower
        print(buzzerPower)

    # 程序入口

    makerobo_setup(makerobo_R, makerobo_G, makerobo_B)
    try:
        makerobo_loop()
    except KeyboardInterrupt:
        makerobo_destroy()