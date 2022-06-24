#include "mainscene.h"
#include<QResource>
#include <QApplication>
#include"config.h"
#include"startscene.h"
#include"restartscene.h"
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    startscene w;
    w.show();
    w.move(400,0);
    return a.exec();
}
