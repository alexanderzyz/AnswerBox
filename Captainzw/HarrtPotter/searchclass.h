#ifndef SEARCHCLASS_H
#define SEARCHCLASS_H
#include<iostream>
#include<QFile>
#include<QString>
#include<QVector>
#include<sstream>
#include<iomanip>
#include<QByteArray>
#include<QMessageBox>
#include<QDebug>
#include<QListWidgetItem>
class searchclass
{
public:
    QString searchname;
    int num;
    int page;
    int chapter;
    QString name;
    static int staticnum;
    static int chapternum;
    QVector<QString> text;
    searchclass(QString ppsearchname, int ppage, int pchapter, QString pname);
    void addtext(QString ptext);
 void changechapternum();
 QString show();
 static void renew();
};



#endif // SEARCHCLASS_H
