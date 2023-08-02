#include "MaterialController.h"
#include <QVariantMap>

MaterialController::MaterialController(QObject *parent): QObject(parent)
{

}

/**
* @brief This function is to fetch all material records from the database and
* transform them into a format that QML can easily handle (QVariantMap)
* @return QList<QVariantMap> - A list of map that contains each material properties
*/
QList<QVariantMap> MaterialController::getAllMaterials() {

    // Fetch all material records from the database
    QList<Material> materialList = m_materialService->getAllMaterials();

    // Initialize an empty QList of QVariantMaps that will hold the transformed material records
    QList<QVariantMap> qmlMaterialList;

    for(const Material &material : materialList) {
        QVariantMap qmlMaterial;
        qmlMaterial.insert("name", QString::fromStdString(material.getName()));
        qmlMaterial.insert("density", material.getDensity());
        qmlMaterialList.append(qmlMaterial);
    }

    return qmlMaterialList;
}

/**
 * @brief Function to calculate the laser parameters based on material properties and operation type
 *
 * @param params A QVariantMap containing the material properties and operation type
 * @return A QVariantMap containing the calculated laser parameters. If required keys are not present in input, returns an empty map.
 */

QVariantMap MaterialController::calculateParams(QVariantMap params){

    // Create a new Material object and a thickness variable
    Material m;
    double thikness =0;

    // Create a map to hold the calculated laser parameters
    QVariantMap qmlParamList;

    qDebug()<<"laserParams before calculation ; " << params ;

    // Check if the required keys are present in the input map
    if (params.contains("thickness") && params.contains("density") && params.contains("material") && params.contains("operation")){

        // Retrieve the values from the input map
        thikness = params["thickness"].toDouble();
        m.setDensity(params["density"].toDouble());
        m.setName(params["material"].toString().toStdString());

        // Calculate the laser parameters
        LaserParam *lp = m_materialService->calculateMaterialParams(m,thikness,params["operation"].toString());

        // Check if the laser parameters could be calculated correctly
        if (lp == nullptr) {
            qmlParamList.insert("error", "Laser parameter calculation failed");
            return qmlParamList;
        }

        // Add the calculated parameters to the output map
        qmlParamList.insert("laserPower", lp->getLaserPower());
        qmlParamList.insert("laserSpeed", lp->getLaserSpeed());
        qmlParamList.insert("focusDepth", lp->getFocusDepth());
        return qmlParamList;
    }
    else
    {
        // If any required key is not present in input, return an error message
        qmlParamList.insert("error", "Required keys are missing in input");

        return qmlParamList;
    }




}
