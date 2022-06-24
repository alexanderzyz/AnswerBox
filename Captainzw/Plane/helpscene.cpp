#include "helpscene.h"
#include<QPainter>
#include<QFont>
#include<QMouseEvent>
helpscene::helpscene(QWidget *parent) : QWidget(parent)
{
this->setFixedSize(GAME_WIDTH,GAME_HEIGHT);
     this->setWindowIcon(QIcon(GAME_ICON));
}
void helpscene::paintEvent(QPaintEvent *ev){
    QPainter painter(this);
    painter.drawPixmap(0,mymap.m_map1_posY,mymap.m_map1);
     painter.drawPixmap(0,mymap.m_map2_posY,mymap.m_map2);
     painter.setPen(Qt::red);
     painter.setFont(QFont("楷体",30));
     painter.drawText(GAME_WIDTH*0.4,GAME_HEIGHT*0.1,"帮助");
     painter.setFont(QFont("楷体",15));
     painter.drawText(GAME_WIDTH*0.01,GAME_HEIGHT*0.2,"1.鼠标按住飞机移动，飞机自动发出子弹射击敌机");
     painter.drawText(GAME_WIDTH*0.01,GAME_HEIGHT*0.28,"2.每击落一架敌机，得分+1");
     painter.drawText(GAME_WIDTH*0.01,GAME_HEIGHT*0.36,"3.每未能击落一架敌机，得分-2");
     painter.drawText(GAME_WIDTH*0.01,GAME_HEIGHT*0.44,"4.点击ESC按钮可以暂停游戏，再次点击ESC或点击继");
     painter.drawText(GAME_WIDTH*0.01,GAME_HEIGHT*0.48,"  续按钮游戏继续");
      painter.drawText(GAME_WIDTH*0.01,GAME_HEIGHT*0.56,"5.随着得分增加，难度会上升");
      painter.drawText(GAME_WIDTH*0.5,GAME_HEIGHT*0.9,"单击鼠标左键以继续...");

}
void helpscene::mousePressEvent(QMouseEvent *ev){
    if(ev->button()==Qt::LeftButton){
        emit sendend();
    }

}
