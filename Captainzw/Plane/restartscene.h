#ifndef RESTARTSCENE_H
#define RESTARTSCENE_H

#include <QWidget>
#include"config.h"
#include<QTimer>
#include"startbutton.h"
#include"map.h"
class restartscene : public QWidget
{
    Q_OBJECT
public:
    explicit restartscene(QWidget *parent = nullptr);
Map mymap;
void paintEvent(QPaintEvent *ev);
startbutton *restartbtn;
QPixmap frame;
signals:
void sendreshow();

};

#endif // RESTARTSCENE_H
