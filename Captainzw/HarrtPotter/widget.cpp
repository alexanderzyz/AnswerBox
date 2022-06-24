#include "widget.h"
#include "ui_widget.h"
QFile *inf[8];
QString bookname[8];
QVector<QString> bookcontain[8];
QVector<searchclass> searchresult;
Widget::Widget(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::Widget)
{
this->setFixedSize(800,580);
    setWindowTitle("哈利波特检索器");
    bookname[0] = "HP7--Harry_Potter_and_the_Deathly_Hallows_Book_7_";
    bookname[1] = "HP2--Harry_Potter_and_the_Chamber_of_Secrets_Book_2_";
    bookname[2] = "J.K. Rowling - HP 0 - Harry Potter Prequel";
    bookname[3] = "J.K. Rowling - HP 3 - Harry Potter and the Prisoner of Azkaban";
    bookname[4] = "J.K. Rowling - HP 4 - Harry Potter and the Goblet of Fire";
    bookname[5] = "J.K. Rowling - HP 6 - Harry Potter and the Half-Blood Prince";
    bookname[6] = "J.K. Rowling - Quidditch Through the Ages";
    bookname[7] = "J.K. Rowling - The Tales of Beedle the Bard";
    inf[0]=new QFile("HP7--Harry_Potter_and_the_Deathly_Hallows_Book_7_.txt");
    inf[1]=new QFile("HP2--Harry_Potter_and_the_Chamber_of_Secrets_Book_2_.txt");
    inf[2]=new QFile("J.K. Rowling - HP 0 - Harry Potter Prequel.txt");
    inf[3]=new QFile("J.K. Rowling - HP 3 - Harry Potter and the Prisoner of Azkaban.txt");
    inf[4]=new QFile("J.K. Rowling - HP 4 - Harry Potter and the Goblet of Fire.txt");
    inf[5]=new QFile("J.K. Rowling - HP 6 - Harry Potter and the Half-Blood Prince.txt");
    inf[6]=new QFile("J.K. Rowling - Quidditch Through the Ages.txt");
    inf[7]=new QFile("J.K. Rowling - The Tales of Beedle the Bard.txt");
    inf[0]->open(QIODevice::ReadOnly);
    inf[1]->open(QIODevice::ReadOnly);
    inf[2]->open(QIODevice::ReadOnly);
    inf[3]->open(QIODevice::ReadOnly);
    inf[4]->open(QIODevice::ReadOnly);
    inf[5]->open(QIODevice::ReadOnly);
    inf[6]->open(QIODevice::ReadOnly);
    inf[7]->open(QIODevice::ReadOnly);
    ui->setupUi(this);
    for(int i=0;i<8;i++){
        inPutmyfile(*inf[i],i);
    };

}

Widget::~Widget()
{
    for(int i=0;i<8;i++){
        inf[i]->close();
    }
    delete ui;
}


void Widget::on_pushButton_clicked()
{
    if(ui->listWidget->count()>0){
        searchresult.clear();
        searchclass::renew();
    }
    while(1){
    if(ui->listWidget->count()>0){
   QListWidgetItem *item;
   item=ui->listWidget->takeItem(0);
   delete item;
    }
    else break;
}

    QString searchquestion=ui->SearchQuestion->text();
    if(searchquestion.isEmpty()){
        QMessageBox Waring(this);
        Waring.setWindowTitle("警告");
        Waring.setText("您输入的查询内容有误");
        Waring.setIcon(QMessageBox::Warning);
        Waring.setStandardButtons(QMessageBox::Ok|QMessageBox::Cancel);
        if(Waring.exec()==QMessageBox::Ok){
            qDebug()<<"Ok is clilked";
        }
    }
    else{
        QString question(searchquestion);

        for(int i=0;i<8;i++)
       { inPutfunction(i,bookname[i],question);
        searchclass::chapternum=0;
        }
    }
 int i=0;
    for(QVector<searchclass>::iterator it=searchresult.begin();it!=searchresult.end();it++,i++){
         ui->listWidget->insertItem(i,(*it).show());
    }

}
void inPutmyfile(QFile &inf,int num) {

    while (!inf.atEnd()) {
        bookcontain[num].push_back(inf.readLine());
    }
}
void inPutfunction(int booknum,QString bookname,QString searchquestion) {
    int num=0;
    for (QVector<QString>::iterator it = bookcontain[booknum].begin(); it != bookcontain[booknum].end(); it++) {
        int tempnum;
        bool ok=false;
        tempnum=(*it).toInt(&ok,10);
        if (ok&&tempnum<1500) {
            num = tempnum;
        }
        int tempchapter1 = (*it).indexOf("Chapter");
        int tempchapter2 = (*it).indexOf("CHAPTER");
        if (tempchapter1 != -1 || tempchapter2 != -1)searchclass::chapternum++;
        Inputtext(it, num, searchquestion, bookname,booknum);
    }
}
void Inputtext(QVector<QString>::iterator it,int num,QString searchquestion,QString bookname,int booknum) {
    int lasttemp = 0;
        int temp = (*it).indexOf(searchquestion, lasttemp);
        while (temp != -1) {
            if (temp != -1) {
                searchclass tempsearch(searchquestion, num + 1, searchclass::chapternum,bookname );
                QVector<QString>::iterator headtext = it;
                while (1) {
                    if ((*headtext).isEmpty()) { headtext--; continue; }
                    int headnum1, headnum2;
                    while (1) {
                        if ((*headtext).isEmpty()) { headtext--; continue; }
                        if (it == headtext) {
                            headnum1 = (*headtext).lastIndexOf(".", temp);
                            headnum2 = (*headtext).lastIndexOf("\"", temp);
                        }
                        else {
                            headnum1 = (*headtext).lastIndexOf(".");
                            headnum2 = (*headtext).lastIndexOf("\"");
                        }
                        if (headnum1 > headnum2) {
                            if (headtext == it) {
                                QString pptext=(*headtext).mid(headnum1 + 1, temp - headnum1 - 1);
                                tempsearch.addtext(pptext);
                                break;
                            }
                            else {
                                QString pptext=(*headtext).mid(headnum1 + 1, (*headtext).length() - headnum1 - 1);
                                if (!pptext.isEmpty())tempsearch.addtext(pptext);
                                headtext++;
                                while (headtext < it) {
                                    tempsearch.addtext(*headtext);
                                    headtext++;
                                }
                                QString pptext2=(*headtext).mid( 0, temp);
                                tempsearch.addtext(pptext2);
                                break;
                            }
                        }
                        else if (headnum1 < headnum2) {
                            if (headtext == it) {
                                QString pptext=(*headtext).mid( headnum2 + 1, temp - headnum2 - 1);
                                tempsearch.addtext(pptext);
                                break;
                            }
                            else {
                                QString pptext=(*headtext).mid( headnum2 + 1, (*headtext).length() - headnum2 - 1);
                                tempsearch.addtext(pptext);
                                headtext++;
                                while (headtext < it) {
                                    tempsearch.addtext(*headtext);
                                    headtext++;
                                }
                                QString pptext2=(*headtext).mid( 0, temp);
                                tempsearch.addtext(pptext2);
                                break;
                            }
                        }
                        else {if(headtext!= bookcontain[booknum].begin()) headtext--;
                        else {
                            QString pptext(*headtext);
                            tempsearch.addtext(pptext);
                            headtext++;
                            while (headtext < it) {
                                tempsearch.addtext(*headtext);
                                headtext++;
                            }
                            QString pptext2=(*headtext).mid( 0, temp);
                            tempsearch.addtext(pptext2);
                            break;
                        }
                        }
                    }
                    break;
                }
                QVector<QString>::iterator lasttext = it;
                while (1) {
                    if ((*lasttext).isEmpty()) { lasttext++; continue; }
                    int lastnum1, lastnum2;
                    while (1) {
                        if ((*lasttext).isEmpty()) { lasttext++; continue; }
                        if (it == lasttext) {
                            lastnum1 = (*lasttext).indexOf(".", temp);
                            lastnum2 = (*lasttext).indexOf("\"", temp);
                        }
                        else {
                            lastnum1 = (*lasttext).indexOf(".");
                            lastnum2 = (*lasttext).indexOf("\"");
                        }
                        if ((lastnum1 > lastnum2 && lastnum2 > 0) || (lastnum1 < lastnum2 && lastnum1 < 0)) {
                            if (lasttext == it) {
                                QString pptext=(*lasttext).mid( temp, lastnum2 - temp + 1);
                                tempsearch.addtext(pptext);
                                break;
                            }
                            else {
                                QString pptext=(*lasttext).mid( 0, lastnum2 + 1);
                                if (!pptext.isEmpty())tempsearch.addtext(pptext);

                                break;
                            }
                        }
                        else if ((lastnum1 < lastnum2 && lastnum1>0) || (lastnum1 > lastnum2 && lastnum2 < 0)) {
                            if (lasttext == it) {
                                QString pptext=(*lasttext).mid( temp, lastnum1 - temp + 1);
                                tempsearch.addtext(pptext);
                                break;
                            }
                            else {
                                QString pptext=(*lasttext).mid( 0, lastnum1 + 1);
                                if (!pptext.isEmpty())tempsearch.addtext(pptext);

                                break;
                            }
                        }
                        else {
                            if (lasttext == it) {
                                QString pptext=(*lasttext).mid( temp, (*lasttext).length() - temp - 1);
                                if (!pptext.isEmpty())tempsearch.addtext(pptext);
                            }
                            else {
                                tempsearch.addtext(*lasttext);
                            }
                            lasttext++;
                        }
                    }
                    break;
                }
                searchresult.push_back(tempsearch);
            }
            temp = (*it).indexOf(searchquestion,temp+1);
        }

}

void Widget::on_listWidget_itemDoubleClicked(QListWidgetItem *item)
{
    QString temp=(*item).text();
    int location=temp.indexOf(" ");
    QString temp2=temp.mid(0,location);
    QMessageBox textdialog(this);
    textdialog.setWindowTitle("内容");
    QString temptext;
    for(QVector<QString>::iterator it=searchresult[temp2.toInt(NULL,10)].text.begin();it!=searchresult[temp2.toInt(NULL,10)].text.end();it++)
{
if((*it).indexOf("Chapter")==-1&&(*it).indexOf("CHAPTER")==-1){
        bool ok;
        (*it).toInt(&ok,10);
    if(!ok&&(*it)!="\n")temptext+=*it;}
}

            textdialog.setText(temptext);
            textdialog.setStandardButtons(QMessageBox::Ok|QMessageBox::Cancel);
            textdialog.exec();

}

void Widget::on_pushButton_2_clicked()
{
    QMessageBox *out=new QMessageBox;
    out->setWindowTitle("您即将退出程序");
    out->setText("您是否想要退出此程序");
    out->setIcon(QMessageBox::Question);
    QPushButton *yesbutton=new QPushButton(QObject::tr("残忍退出!"));
    QPushButton *nobutton=new QPushButton(QObject::tr("点错了.."));
    out->addButton(yesbutton,QMessageBox::YesRole);
    out->addButton(nobutton,QMessageBox::NoRole);
    connect(yesbutton,&QPushButton::clicked,this,&QWidget::close);

    out->exec();

}
