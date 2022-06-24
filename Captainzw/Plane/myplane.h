#ifndef MYPLANE_H
#define MYPLANE_H
#include<QPixmap>
#include"bullet.h"
class myplane
{
public:
    myplane();
    void shoot();
    void setPosition(int x,int y);
public:
    QPixmap m_Plane;
    int m_x;
    int m_y;
    QRect m_Rect;
    bullet m_bullets[BULLET_NUM];
    int m_recorder;
};

#endif // MYPLANE_H
