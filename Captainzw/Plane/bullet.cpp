#include "bullet.h"

bullet::bullet()
{
m_bullet.load(BULLET_PATH);
m_x=GAME_WIDTH*0.5-m_bullet.width()*0.5;
m_y=GAME_HEIGHT;
m_free=true;
m_speed=BULLET_SPEED;
m_Rect.setWidth(m_bullet.width());
m_Rect.setHeight(m_bullet.height());
m_Rect.moveTo(m_x,m_y);
}
void bullet::updatePosition(){
    if(m_free){return;}
    m_y-=m_speed;
    m_Rect.moveTo(m_x,m_y);
    if(m_y<=-m_Rect.height()){m_free=true;}
}
