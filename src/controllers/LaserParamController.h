#ifndef LASERPARAMCONTROLLER_H
#define LASERPARAMCONTROLLER_H
#include <QVariantMap>

#include <QObject>
#include "src/services/LaserParamService.h"
class LaserParamController: public QObject
{
    Q_OBJECT

public:
    explicit LaserParamController(QObject *parent = nullptr);
    Q_INVOKABLE void saveLaserParams(QVariantMap params);
    Q_INVOKABLE QVariantMap loadLaserParams();

private:
    LaserParamService* m_service;
    LaserParam laserParam;
signals:
    void saveLaserParamsCompleted(bool success, QString errorMessage);

};

#endif // LASERPARAMCONTROLLER_H
