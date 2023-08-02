// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

#include <QGuiApplication>
#include <QQmlApplicationEngine>

// Import necessary custom headers
#include "app_environment.h"
#include "import_qml_components_plugins.h"
#include "import_qml_plugins.h"
#include "database/DBConnection.h"
#include "controllers/LaserParamController.h"
#include "controllers/MaterialController.h"

int main(int argc, char *argv[])
{
    set_qt_environment();// Set up the Qt environment

    QGuiApplication app(argc, argv);// Create a new QGuiApplication object

    // Register LaserParamController and MaterialController types with the QML type system
    qmlRegisterType<LaserParamController>("io.qt.examples.laserparamcontroller", 1, 0, "LaserParamController");
    qmlRegisterType<MaterialController>("io.qt.examples.materialController", 1, 0, "MaterialController");



    QQmlApplicationEngine engine;// Create a new QQmlApplicationEngine object
    const QUrl url(u"qrc:Main/main.qml"_qs);// Create a QUrl object pointing to the main QML file
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard")); // Set an environment variable for Qt's input module

    qDebug() << "Qt version:" << qVersion();

    // Connect the objectCreated signal from the QQmlApplicationEngine to a function
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url](QObject *obj, const QUrl &objUrl) {
            // If object creation failed and the object's url is the main QML file, terminate the application
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");

    engine.load(url);

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }
    DBConnection connection; // Create a new DBConnection object
    bool connectionState = connection.openDatabase();
    // Check the state of the connection and log the state to console
    if(!connectionState){
        qDebug() << "Connection established:" << connectionState;
        return -1;// If connection could not be established, terminate the application
    }
    else
    {
        qDebug() << "Connection established:" << connectionState;
        connection.createMaterialTable();// If connection was established, create the Material table
    }

    return app.exec();// Start the event loop of the application
}
