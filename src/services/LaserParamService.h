#ifndef LASERPARAMSERVICE_H
#define LASERPARAMSERVICE_H

#include "src/models/LaserParam.h"
#include <QObject>

class LaserParamService : public QObject
{
    Q_OBJECT
public:
    explicit LaserParamService(QObject *parent = nullptr);
    virtual ~LaserParamService();

    void loadParams(LaserParam* model);
    void saveParams(const LaserParam* model);
};

#endif // LASERPARAMSERVICE_H
