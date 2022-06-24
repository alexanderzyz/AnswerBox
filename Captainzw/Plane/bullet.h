#ifndef BULLET_H
#define BULLET_H
#include<QPixmap>
#include"config.h"
class bullet
{
public:
    bullet();
    void updatePosition();
public:
    QPixmap m_bullet;
    int m_x;
    int m_y;
    int m_speed;
    bool m_free;
    QRect m_Rect;
};

#endif // BULLET_H
