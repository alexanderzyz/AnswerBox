#!/usr/bin/python3

import aliLink,mqttd
import time,json


# 三元素（iot后台获取）
ProductKey = 'h5bfhHguf8e'
DeviceName = 'raspberry'
DeviceSecret = "e26c9bdfab750297fd19377bf2310c5e"
# topic (iot后台获取)
POST = '/sys/h5bfhHguf8e/raspberry/thing/event/property/post'  # 上报消息到云
POST_REPLY = '/sys/h5bfhHguf8e/raspberry/thing/event/property/post_reply'
SET = 'sys/h5bfhHguf8e/raspberry/thing/service/property/set'  # 订阅云端指令
def send(queue):
    # 消息回调（云端下发消息的回调函数）
    def on_message(client, userdata, msg):
        #print(msg.payload)
        print(msg.payload)  # 开关值

    #连接回调（与阿里云建立链接后的回调函数）
    def on_connect(client, userdata, flags, rc):
        print("Connected with result code "+str(rc))
        pass


    # 链接信息
    Server,ClientId,userNmae,Password = aliLink.linkiot(DeviceName,ProductKey,DeviceSecret)

    # mqtt链接
    mqtt = mqttd.MQTT(Server,ClientId,userNmae,Password)
    mqtt.subscribe(SET) # 订阅服务器下发消息topic
    mqtt.begin(on_message,on_connect)


    # 信息获取上报，每10秒钟上报一次系统参数
    while True:
        time.sleep(1)
        TIREDNESS_COUNT=queue.get()
        Tiredness=float(TIREDNESS_COUNT)
        # 构建与云端模型一致的消息结构
        updateMsn = {
            "Tiredness": Tiredness,
        }
        JsonUpdataMsn = aliLink.Alink(updateMsn)
        print(JsonUpdataMsn)

        mqtt.push(POST,JsonUpdataMsn) # 定时向阿里云IOT推送我们构建好的Alink协议数据
