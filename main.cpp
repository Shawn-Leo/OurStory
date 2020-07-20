#include <QApplication>
//导入串口包
#include <QCoreApplication>
#include <QList>
#include <stdio.h>
#include <QDebug>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>

//创建websocket
#include <QWebSocketServer>
#include "inspectionserver.h"


int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
//    MainWindow w;
//    w.show();
    qDebug()<< "main.cpp执行了";
    InspectionServer server(4396);

    return a.exec();
}
