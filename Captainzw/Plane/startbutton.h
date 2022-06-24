#ifndef STARTBUTTON_H
#define STARTBUTTON_H
#include<QPixmap>
#include"config.h"
#include<QPushButton>
#include<QSize>
class startbutton:public QPushButton
{

public:
    startbutton(int btntype);
void zoom1();
void zoom2();
public:
    int myx;
    int myy;
QPixmap mystartbutton;
QRect startbuttonrect;
};

#endif // STARTBUTTON_H
