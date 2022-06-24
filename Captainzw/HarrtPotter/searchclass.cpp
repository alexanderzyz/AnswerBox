#include"searchclass.h"
int searchclass::chapternum = 0;
int searchclass::staticnum = 0;

searchclass::searchclass(QString ppsearchname, int ppage, int pchapter, QString pname)
{	searchname = ppsearchname;
    staticnum++;
    num = staticnum;
    page = ppage;
    chapter = pchapter;
    name = pname;

}
void searchclass::addtext(QString ptext) {
    text.push_back(ptext);
}
void searchclass:: changechapternum() {
    chapternum = 0;
}
QString searchclass::show(){
    QString tempstring;
    QString tempnum;
    tempnum.setNum(num);
    tempstring+=tempnum;
    tempstring+="          ";
    tempstring+=searchname;
    tempstring+="             ";
    tempnum.setNum(page);
    tempstring+=tempnum;
    tempstring+="            ";
    tempnum.setNum(chapter);
    tempstring+=tempnum;
    tempstring+="              ";
    tempstring+=name;
    return tempstring;
}
 void searchclass::renew(){
    staticnum=0;
    chapternum=0;

}
