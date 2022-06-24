#include "enemyplane.h"
#include"config.h"
#include"mainscene.h"
EnemyPlane::EnemyPlane()
{
m_enemy.load(ENEMY_PATH);
m_x=0;
m_y=0;
outscreen=0;
m_Free=true;
m_Speed=ENEMY_SPEED;
m_Rect.setWidth(m_enemy.width());
m_Rect.setHeight(m_enemy.height());
m_Rect.moveTo(m_x,m_y);
}
void EnemyPlane::updatePosition()
{
    m_Speed=ENEMY_SPEED+MainScene::recorde/50;
    if(m_Free){return;}
    m_y+=m_Speed;
    m_Rect.moveTo(m_x,m_y);
    if(m_y>=GAME_HEIGHT+m_Rect.height()){m_Free=true;outscreen++;}
}
