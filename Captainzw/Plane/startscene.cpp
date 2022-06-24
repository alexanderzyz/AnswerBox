#include "startscene.h"
#include<QPainter>
#include<QPushButton>
#include<QDebug>
startscene::startscene(QWidget *parent) : QWidget(parent)
{
this->setFixedSize(GAME_WIDTH,GAME_HEIGHT);
    this->setWindowIcon(QIcon(GAME_ICON));
   button=new startbutton(1);
    button->setParent(this);
    button->move(button->myy,button->myx);
    connect(button,&startbutton::clicked,[=](){
       button->zoom1();
      button->zoom2();

        QTimer::singleShot(250,this,[=](){
            this->hide();
            myhelpscene=new helpscene();
            myhelpscene->show();
            myhelpscene->move(400,0);
            connect(myhelpscene,&helpscene::sendend,[=](){
                QTimer::singleShot(100,myhelpscene,[=](){
                    myhelpscene->hide();
                    mymainscene=new MainScene();
                 mymainscene->show();
                 mymainscene->move(400,0);
                            reshow();


                });

            });



        });

    });


}
void startscene::paintEvent(QPaintEvent *ev){
    QPainter painter(this);
    painter.drawPixmap(0,mymap.m_map1_posY,mymap.m_map1);
     painter.drawPixmap(0,mymap.m_map2_posY,mymap.m_map2);
}
void startscene::reshow(){
    connect(mymainscene,&MainScene::sendreshow,[=](){
        delete mymainscene;
        mymainscene=new MainScene();
        mymainscene->show();
        mymainscene->move(400,0);
     reshow();
    });


}
