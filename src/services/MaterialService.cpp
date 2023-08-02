#include "materialservice.h"
#include <QDebug>
#include "src/database/DBConnection.h"
#include "src/models/Material.h"
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QSqlRecord>

MaterialService::MaterialService(DBConnection* dbConnection)
    : m_dbConnection(dbConnection)
{
}

/**
 * @brief Fetches all the material data from the database.
 *
 * @return QList<Material> A list of Material objects, each representing a row from the 'material' table in the database.
 */
QList<Material> MaterialService::getAllMaterials() {

    // Create a new QSqlQueryModel
    QSqlQueryModel * model= new QSqlQueryModel();

    // Set the SQL query to be executed by this model
    // This query fetches all rows from the 'material' table
    model->setQuery("SELECT * FROM material");

    // Create an empty QList of Material objects to hold the materials fetched from the database
    QList<Material> materialList;

    // Temporary Material object to be used in the loop
    Material mat;

    // Iterate over each row fetched by the model
    for (int i = 0; i < model->rowCount(); ++i) {
        mat.setName( model->record(i).value("name").toString().toStdString());
        mat.setDensity( model->record(i).value("density").toDouble());
        materialList.append(mat);
    }
    return materialList;
}

/**
 * @brief Calculate laser parameters based on the material, thickness, and operation.
 *  NP : This formula is not exact , I made it as a proof of concept and we can change it Later :)
 * The function calculates laser power, laser speed, and focus depth based on
 * the provided material's density, thickness, and operation type.
 * These calculated parameters are then used to create a new LaserParam object
 * which is then returned.
 *
 * @param material The Material object representing the material to be processed.
 * @param thickness The thickness of the material to be processed.
 * @param operation The operation to be performed (either "Cut" or otherwise).
 *
 * @return LaserParam* Pointer to the newly created LaserParam object containing the calculated parameters.
 */
LaserParam* MaterialService::calculateMaterialParams(Material material,double thickness,QString operation ){
    if(operation ==  "Cut")
    {
        double laserPower = qBound(0.0,material.getDensity() * thickness * 10, 5000.0);
        double laserSpeed = qBound(1.0, 10000/ (material.getDensity() * thickness), 500.0);
        double focusDepth = qBound(1.0,thickness, 50.0);
        LaserParam* lp = new LaserParam(nullptr,-1,-1,-1,-1,-1,-1,laserPower,laserSpeed,focusDepth,"none","none");
        return lp;

    }
    else {
        double laserPower = qBound(0.0,material.getDensity() * thickness * 5, 5000.0);
        double laserSpeed = qBound(1.0,10000/ (material.getDensity() * thickness), 500.0);
        double focusDepth = qBound(1.0,thickness / 2, 50.0);
        LaserParam* lp = new LaserParam(nullptr,-1,-1,-1,-1,-1,-1,laserPower,laserSpeed,focusDepth,"none","none");
        return lp;
    }
}
