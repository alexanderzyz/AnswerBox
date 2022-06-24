#include "mainscene.h"
#include"config.h"
#include<QIcon>
#include<QPainter>
#include<QMouseEvent>
#include<ctime>
#include<QLabel>
#include<QColor>
int MainScene::recorde=0;
MainScene::MainScene(QWidget *parent)
    : QWidget(parent)
{initScene();
     playGame();
}

MainScene::~MainScene()
{
}

void MainScene::initScene(){
    setFixedSize(GAME_WIDTH,GAME_HEIGHT);
    setWindowTitle(GAME_TITLE);
    setWindowIcon(QIcon(GAME_ICON));
    m_Timer.setInterval(GAME_RATE);
    m_recorder=0;    
    recorde=0;
     srand((unsigned int)time(NULL));
     pausebtn=new startbutton(3);
     pausebtn->setParent(this);
     pausebtn->move(pausebtn->myy,pausebtn->myx);
     pausebtn->hide();
     connect(pausebtn,&QPushButton::clicked,[=](){
         pausebtn->zoom1();
         pausebtn->zoom2();
         QTimer::singleShot(200,this,[=](){
             pausebtn->hide();
             m_Timer.start();
         }
         );

     });

     my_plane=new myplane();
for(int i=0;i<ENEMY_NUM;i++){
m_enemys[i]=new EnemyPlane();

}}
void MainScene::playGame(){
    m_Timer.start();
    connect(&m_Timer,&QTimer::timeout,[=](){
        enemyToScene();
    updatePosition();
    update();
    collisionDetection();

    if(defeat()){
        m_Timer.stop();
        QTimer::singleShot(2000,this,[=](){
            restart=new restartscene();
            this->hide();
            restart->show();
            restart->move(400,0);
            connect(restart,&restartscene::sendreshow,[=](){
             this->hide();
                emit sendreshow();

            });
          }
                );
}
    });
}
void MainScene::updatePosition(){
    m_map.mapPosition();
    my_plane->shoot();
    for(int i=0;i<BULLET_NUM;i++){
        if(!my_plane->m_bullets[i].m_free){
            my_plane->m_bullets[i].updatePosition();
        }
    }
    for(int i = 0 ; i< ENEMY_NUM;i++)
       {
           //非空闲敌机 更新坐标
          if(m_enemys[i]->m_Free == false)
          {
             m_enemys[i]->updatePosition();
             if( m_enemys[i]->outscreen>0){
            if(recorde>=2){
                 recorde-=2;
            m_enemys[i]->outscreen=0;
            }
            else{ m_enemys[i]->outscreen=0;}
             }
          }
       }
}
void MainScene::paintEvent(QPaintEvent *event){
    QPainter painter(this);
    painter.setPen(Qt::red);
    painter.setFont(QFont("楷体",15));
    painter.drawPixmap(0,m_map.m_map1_posY,m_map.m_map1);
     painter.drawPixmap(0,m_map.m_map2_posY,m_map.m_map2);
     painter.drawPixmap(my_plane->m_x,my_plane->m_y,my_plane->m_Plane);
     QString recstring("得分：");
     QString recint=QString::number(recorde);
     painter.drawText(0.8*GAME_WIDTH,20,recstring+recint);
     for(int i=0;i<BULLET_NUM;i++){
         if(!my_plane->m_bullets[i].m_free){
             painter.drawPixmap(my_plane->m_bullets[i].m_x,my_plane->m_bullets[i].m_y,my_plane->m_bullets[i].m_bullet);
         }
     }
     for(int i = 0 ; i< ENEMY_NUM;i++)
         {
             if(m_enemys[i]->m_Free == false)
             {
                 painter.drawPixmap(m_enemys[i]->m_x,m_enemys[i]->m_y,m_enemys[i]->m_enemy);
             }
         }
     if(defeat()){
         painter.setFont(QFont("楷体",30));
         painter.drawText(0.5*GAME_WIDTH-90,0.5*GAME_HEIGHT-15,"游戏结束");
          painter.setFont(QFont("楷体",20));
         painter.drawText(0.5*GAME_WIDTH-60,0.5*GAME_HEIGHT+15,"得分："+QString::number(recorde));

     }
}
void MainScene::mouseMoveEvent(QMouseEvent *event){
    int x=event->x() - my_plane->m_Rect.width()*0.5;
     int y=event->y() - my_plane->m_Rect.height()*0.5;
     if(x<=0){x=0;}
     if(x>=GAME_WIDTH-my_plane->m_Rect.width()){x=GAME_WIDTH-my_plane->m_Rect.width();}
     if(y<=0){y=0;}
     if(y>=GAME_HEIGHT-my_plane->m_Rect.height()){y=GAME_HEIGHT-my_plane->m_Rect.height();}
my_plane->setPosition(x,y);

}
void MainScene::enemyToScene()
{
    m_recorder++;
    if(m_recorder < ENEMY_INTERVAL-recorde/10)
    {
        return;
    }

    m_recorder = 0;

    for(int i = 0 ; i< ENEMY_NUM;i++)
    {
        if(m_enemys[i]->m_Free)
        {
            m_enemys[i]->m_Free = false;
            m_enemys[i]->m_x = rand() % (GAME_WIDTH - m_enemys[i]->m_Rect.width());
            m_enemys[i]->m_y = -m_enemys[i]->m_Rect.height();
            break;
        }
    }
}
void MainScene::collisionDetection()
{
    //遍历所有非空闲的敌机
    for(int i = 0 ;i < ENEMY_NUM;i++)
    {
        if(m_enemys[i]->m_Free)
        {
            continue;
        }

        for(int j = 0 ; j < BULLET_NUM;j++)
        {
            if(my_plane->m_bullets[j].m_free)
            {

                continue;
            }

            if(m_enemys[i]->m_Rect.intersects(my_plane->m_bullets[j].m_Rect))
            {
                m_enemys[i]->m_Free = true;
                my_plane->m_bullets[j].m_free = true;
                recorde++;
            }
        }
    }
}

bool MainScene::defeat(){

    for(int i = 0 ;i < ENEMY_NUM;i++)
    {
        if(m_enemys[i]->m_Free)
        {
            continue;
        }

            if(m_enemys[i]->m_Rect.intersects(my_plane->m_Rect))
            {

                return true;
               }
        }
        return false;
    }

void MainScene::reshow(){
    this->show();
}

void MainScene::keyPressEvent(QKeyEvent *ev){
    if(ev->key()==Qt::Key_Escape){
       if(pausebtn->isHidden()) {
            pausebtn->show();
                pausebtn->move(pausebtn->myy,pausebtn->myx);
                    m_Timer.stop();


    }
    else{
            pausebtn->hide();
            m_Timer.start();

        }
    }


}
