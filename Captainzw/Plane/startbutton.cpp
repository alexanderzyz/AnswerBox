#include "startbutton.h"
#include<QDebug>
#include<QPropertyAnimation>
startbutton::startbutton(int btntype)
{if(btntype==1)
    {
    QSize mysize(300,200);
mystartbutton.load(START_BUTTON_PATH);
mystartbutton=mystartbutton.scaled(mysize,Qt::KeepAspectRatio);
myx=GAME_HEIGHT*0.6;
myy=GAME_WIDTH*0.5-0.3*mystartbutton.width();
this->setIcon(mystartbutton);
this->setIconSize(QSize(mystartbutton.width(),mystartbutton.height()));
this->setFixedSize(QSize(0.61*mystartbutton.width(),0.33*mystartbutton.height()));
this->setStyleSheet("QPushButton{border:0px;}");
    }
    else if(btntype==2){
        QSize mysize(50,50);
    mystartbutton.load(RESTART_BUTTON_PATH);
    mystartbutton=mystartbutton.scaled(mysize,Qt::KeepAspectRatio);
    myx=GAME_HEIGHT*0.53;
    myy=GAME_WIDTH*0.5-0.5*mystartbutton.width();
    this->setIcon(mystartbutton);
    this->setIconSize(QSize(mystartbutton.width(),mystartbutton.height()));
    this->setFixedSize(QSize(mystartbutton.width(),mystartbutton.height()));
    this->setStyleSheet("QPushButton{border:0px;}");

    }
   else if(btntype==3){
        QSize mysize(80,80);
                mystartbutton.load(CONTINUE_PATH);
                mystartbutton=mystartbutton.scaled(mysize,Qt::KeepAspectRatio);
                myx=GAME_HEIGHT*0.53;
                myy=GAME_WIDTH*0.5-0.5*mystartbutton.width();
                this->setIcon(mystartbutton);
                this->setIconSize(QSize(mystartbutton.width(),mystartbutton.height()));
                this->setFixedSize(QSize(mystartbutton.width(),mystartbutton.height()));
                this->setStyleSheet("QPushButton{border:0px;}");

    }
}
void startbutton::zoom1(){
    QPropertyAnimation *animation=new QPropertyAnimation(this,"geometry");
    animation->setDuration(150);
    animation->setStartValue(QRect(this->x(),this->y(),this->width(),this->height()));
    animation->setEndValue(QRect(this->x(),this->myy+10,this->width(),this->height()));
    animation->setEasingCurve(QEasingCurve::OutBounce);
    animation->start();

};

void startbutton::zoom2(){
    QPropertyAnimation *animation=new QPropertyAnimation(this,"geometry");
    animation->setDuration(150);
    animation->setStartValue(QRect(this->x(),this->y()+10,this->width(),this->height()));
    animation->setEndValue(QRect(this->x(),this->y(),this->width(),this->height()));
    animation->setEasingCurve(QEasingCurve::OutBounce);
    animation->start();


}
;
