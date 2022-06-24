#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include"searchclass.h"
void inPutfunction(int,QString,QString);
void inPutmyfile(QFile&, int);
void showResult();
void Inputtext(QVector<QString>::iterator it, int num, QString searchquestion,QString bookname, int booknum);
QT_BEGIN_NAMESPACE
namespace Ui { class Widget; }
QT_END_NAMESPACE

class Widget : public QWidget
{
    Q_OBJECT

public:
    Widget(QWidget *parent = nullptr);
    ~Widget();

private slots:
    void on_pushButton_clicked();

    void on_listWidget_itemDoubleClicked(QListWidgetItem *item);

    void on_pushButton_2_clicked();

private:
    Ui::Widget *ui;
};
#endif // WIDGET_H
