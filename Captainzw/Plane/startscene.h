#ifndef STARTSCENE_H
#define STARTSCENE_H

#include <QWidget>
#include"config.h"
#include<QTimer>
#include"mainscene.h"
#include"startbutton.h"
#include"map.h"
#include"helpscene.h"
class startscene : public QWidget
{
    Q_OBJECT
public:
    explicit startscene(QWidget *parent = nullptr);
startbutton *button;
MainScene *mymainscene;
void paintEvent(QPaintEvent *ev);
Map mymap;
void reshow();
helpscene *myhelpscene;
signals:

};

#endif // STARTSCENE_H
