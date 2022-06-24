#include "widget.h"

#include <QApplication>
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Widget w;
    w.show();
    w.setWindowTitle("哈利波特检索器");
    return a.exec();
}
