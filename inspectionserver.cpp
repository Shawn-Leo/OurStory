#include "inspectionserver.h"

#include <QDebug>

InspectionServer::InspectionServer(uint16_t port)
    : websocketServer(new QWebSocketServer(QStringLiteral("Inspection server"), QWebSocketServer::NonSecureMode))
{
    if(this->websocketServer->listen(QHostAddress("117.183.24.155"), port))
    {
        QObject::connect(websocketServer.get(), SIGNAL(newConnection()), this, SLOT(onNewConnection()));
    }
    else
    {
        throw std::runtime_error("InspectionServer: failed to listen");
    }
}

void InspectionServer::onNewConnection()
{
    qInfo() << "InspectionServer::onNewConnection";
    QWebSocketPtr socket(this->websocketServer->nextPendingConnection());

    QObject::connect(socket.get(), SIGNAL(textMessageReceived(const QString&)), this, SLOT(processTextMessage(const QString&)));
    QObject::connect(socket.get(), SIGNAL(disconnected()), this, SLOT(socketDisconnected()));

    socket->sendTextMessage("Hi Client!");
    this->clients.append(socket);
}

void InspectionServer::processTextMessage(const QString& message)
{
    qInfo() << "InspectionServer::processTextMessage: " << message;
}

void InspectionServer::socketDisconnected()
{
    qInfo() << "InspectionServer::socketDisconnected";
}
