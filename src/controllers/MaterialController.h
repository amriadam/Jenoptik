#ifndef MATERIALCONTROLLER_H
#define MATERIALCONTROLLER_H
#include <QVariantMap>

#include <QObject>
#include "src/services/MaterialService.h"
#include "src/services/LaserParamService.h"


class MaterialController: public QObject
{
    Q_OBJECT
public:
    explicit MaterialController(QObject *parent = nullptr);
    Q_INVOKABLE QList<QVariantMap> getAllMaterials();
    Q_INVOKABLE QVariantMap calculateParams(QVariantMap params);
private:
    MaterialService* m_materialService;
    LaserParamService* m_laserParamService;

signals:
    void calculateParamsCompleted(bool success, QString errorMessage);
};

#endif // MATERIALCONTROLLER_H
