#ifndef HELPSCENE_H
#define HELPSCENE_H

#include <QWidget>
#include"config.h"
#include <QWidget>
#include"config.h"
#include<QTimer>
#include"mainscene.h"
#include"startbutton.h"
#include"map.h"
class helpscene : public QWidget
{
    Q_OBJECT
public:
    explicit helpscene(QWidget *parent = nullptr);
Map mymap;
void paintEvent(QPaintEvent *ev);
void mousePressEvent(QMouseEvent* ev);
signals:
void sendend();
};

#endif // HELPSCENE_H
