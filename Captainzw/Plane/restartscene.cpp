#include "restartscene.h"
#include<QPainter>
#include<QDebug>
#include"mainscene.h"
restartscene::restartscene(QWidget *parent) : QWidget(parent)
{
    frame.load(FRAME_PATH);
    frame=frame.scaled(GAME_WIDTH,GAME_HEIGHT*0.35);
    this->setFixedSize(GAME_WIDTH,GAME_HEIGHT);
    restartbtn=new startbutton(2);
    restartbtn->setParent(this);
    restartbtn->move(restartbtn->myy,restartbtn->myx);
    connect(restartbtn,&QPushButton::clicked,[=](){
        restartbtn->zoom1();
        restartbtn->zoom2();
        QTimer::singleShot(300,this,[=](){

            this->hide();
            emit sendreshow();
        });
    });
}
void restartscene::paintEvent(QPaintEvent *ev){
    QPainter painter(this);
    painter.drawPixmap(0,mymap.m_map1_posY,mymap.m_map1);
     painter.drawPixmap(0,mymap.m_map2_posY,mymap.m_map2);
     painter.drawPixmap(0,GAME_HEIGHT*0.3,frame);
     painter.setFont(QFont("楷体",30));
     painter.drawText(0.5*GAME_WIDTH-75,0.5*GAME_HEIGHT-15,"游戏结束");
      painter.setFont(QFont("楷体",20));
     painter.drawText(0.5*GAME_WIDTH-45,0.5*GAME_HEIGHT+15,"得分："+QString::number(MainScene::recorde));
}
