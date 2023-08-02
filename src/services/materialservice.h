#ifndef MATERIALSERVICE_H
#define MATERIALSERVICE_H
#include <QVariantMap>
#include <QSqlQueryModel>
#include "src/database/DBConnection.h"
#include "src/models/Material.h"
#include "src/models/LaserParam.h"

class MaterialService {
public:
    MaterialService(DBConnection* dbConnection);
    QList<Material>  getAllMaterials();
    LaserParam* calculateMaterialParams(Material material,double thickness,QString operation );
private:
    DBConnection* m_dbConnection;
};

#endif // MATERIALSERVICE_H
