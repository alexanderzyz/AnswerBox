#ifndef MAINSCENE_H
#define MAINSCENE_H
#include <QTimer>
#include <QWidget>
#include"map.h"
#include"myplane.h"
#include"bullet.h"
#include"enemyplane.h"
#include<QLabel>
#include"restartscene.h"
class MainScene : public QWidget
{
    Q_OBJECT

public:
     MainScene(QWidget *parent = nullptr);
    ~MainScene();
void initScene();
QTimer m_Timer;
void playGame();
void updatePosition();
void paintEvent(QPaintEvent *event);
Map m_map;
myplane *my_plane;
void mouseMoveEvent(QMouseEvent *event);
void enemyToScene();
EnemyPlane *m_enemys[ENEMY_NUM];
int m_recorder;
static int recorde;
void collisionDetection();
void updaterecorde();
bool defeat();
restartscene *restart;
void reshow();
void keyPressEvent(QKeyEvent* ev);
startbutton *pausebtn;
signals:
void sendreshow();
void pausegame();
};
#endif // MAINSCENE_H
