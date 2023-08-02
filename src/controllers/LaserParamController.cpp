#include "LaserParamController.h"
#include "src/models/LaserParam.h"
#include <QVariantMap>

LaserParamController::LaserParamController(QObject *parent)
    : QObject(parent)
{
}

/**
 * @brief Saves the given laser parameters.
 *
 * This function receives a QVariantMap of laser parameters, validates them,
 * sets these parameters to a LaserParam object, and saves them using a service object.
 * It emits signals to indicate whether the saving process has been completed successfully.
 *
 * If the process fails (due to an invalid value or an exception during the saving process),
 * it emits saveLaserParamsCompleted with the first parameter as false and the second as the error message.
 *
 * @param params a QVariantMap containing the parameters to be saved.
 */
void LaserParamController::saveLaserParams(QVariantMap params)
{
    // create a new LaserParam object
    LaserParam laserParam;

    // output parameters for debugging
    qDebug() << "params: " << params;

    // in this section we will check if every parameter exists in the params, if it doesnt we give it a default value (-1) or "none"
    // if it exists we check if its in the range ,if it is we save it in the object else we emit an error signal and return
    if (params.contains("laserBeamDiameter")) {
        double laserBeamDiameter = params["laserBeamDiameter"].toDouble();
        if (!std::isnan(laserBeamDiameter)) {
            if(laserBeamDiameter <= 500 && laserBeamDiameter >= 10)
            {
                laserParam.setLaserBeamDiameter(laserBeamDiameter);
            }
            else
            {
                emit saveLaserParamsCompleted(false, "Laser beam diameter out of range!");
                return;
            }
        }
    } else {
        laserParam.setLaserBeamDiameter(-1);
    }

    //----------------

    if (params.contains("pulseFrequency")) {
        double pulseFrequency = params["pulseFrequency"].toDouble();
        if (!std::isnan(pulseFrequency)) {
            if(pulseFrequency >=1 && pulseFrequency <= 100){
                laserParam.setPulseFrequency(pulseFrequency);
            }
            else{
                emit saveLaserParamsCompleted(false, "Laser beam diameter out of range!");
                return;
            }
        }
    }else {
        laserParam.setPulseFrequency(-1);
    }

    //----------------

    if (params.contains("scanSpeed")) {
        double scanSpeed = params["scanSpeed"].toDouble();
        if (!std::isnan(scanSpeed)) {
            if(scanSpeed >=1 && scanSpeed <=5000){
                laserParam.setScanSpeed(scanSpeed);
            }
            else {
                emit saveLaserParamsCompleted(false, "Scan Speed out of range!");
                return;
            }

        }
    }else {
        laserParam.setScanSpeed(-1);
    }

    //----------------

    if (params.contains("spotDiameter")) {
        double spotDiameter = params["spotDiameter"].toDouble();
        if (!std::isnan(spotDiameter)) {
            if(spotDiameter >=1 && spotDiameter <= 500 )
            {
                laserParam.setSpotDiameter(spotDiameter);
            }
            else {

                emit saveLaserParamsCompleted(false, "Spot diameter out of range!");
                return;
            }
        }
    }else {
        laserParam.setSpotDiameter(-1);
    }

    //----------------

    if (params.contains("focusDistance")) {
        double focusDistance = params["focusDistance"].toDouble();
        if (!std::isnan(focusDistance)) {
            if(focusDistance>=1 && focusDistance<= 500){
                laserParam.setFocusDistance(focusDistance);
            }
            else{
                emit saveLaserParamsCompleted(false, "Focus distance out of range!");
                return;
            }

        }
    }else {
        laserParam.setFocusDistance(-1);
    }

    //----------------

    if (params.contains("dutyCycle")) {
        double dutyCycle = params["dutyCycle"].toDouble();
        if (!std::isnan(dutyCycle)) {
            if(dutyCycle>=0 && dutyCycle<=100){
                laserParam.setDutyCycle(dutyCycle);
            }
            else{
                qDebug() << "problem 5: " ;
                emit saveLaserParamsCompleted(false, "Duty Cycle out of range!");
                return;
            }

        }
    }else {
        laserParam.setDutyCycle(-1);
    }

    //----------------


    if (params.contains("laserPower")) {
        double laserPower = params["laserPower"].toDouble();
        if (!std::isnan(laserPower)) {
            if(laserPower>=0 && laserPower<= 5000){
                laserParam.setLaserPower(laserPower);
            }
            else{
                emit saveLaserParamsCompleted(false, "Laser Power out of range!");
                return;
            }
        }
    }else {
        laserParam.setLaserPower(-1);
    }

    //----------------

    if (params.contains("laserSpeed")) {
        double laserSpeed = params["laserSpeed"].toDouble();
        if (!std::isnan(laserSpeed)) {
            if(laserSpeed >= 1 && laserSpeed <= 500){
                laserParam.setLaserSpeed(laserSpeed);
            }
            else {
                emit saveLaserParamsCompleted(false, "Laser Speed out of range!");
                return;
            }
        }
    }else {
        laserParam.setLaserSpeed(-1);
    }

    //----------------

    if (params.contains("focusDepth")) {
        double focusDepth = params["focusDepth"].toDouble();
        if (!std::isnan(focusDepth)) {
            if(focusDepth >= 1 && focusDepth <= 50){
                laserParam.setFocusDepth(focusDepth);
            }
            else{
                emit saveLaserParamsCompleted(false, "Focus Depth out of range!");
                return;
            }
        }
    }
    else {
        laserParam.setFocusDepth(-1);
    }

    //----------------


    if (params.contains("beamShape")) {
        QString beamShape = params["beamShape"].toString();
        if(beamShape == "Top-Hat" || beamShape == "Gaussian" ){
            laserParam.setBeamShape(beamShape);
        }
        else{
            emit saveLaserParamsCompleted(false, "Beam Shape out of range!");
            return;
        }

    }else {
        laserParam.setBeamShape("none");
    }

    //----------------


    if (params.contains("assistGas")) {
        QString assistGas = params["assistGas"].toString();
        if(assistGas == "Nitrogen" || assistGas == "Oxygen" ){
            laserParam.setAssistGas(assistGas);
        }
        else{
            emit saveLaserParamsCompleted(false, "Assis tGas out of range!");
            return;
        }
    }else {
        laserParam.setAssistGas("none");
    }

    //----------------


    qDebug() << "LaserParam: " << laserParam.toString();

    try {
        m_service->saveParams(&laserParam);
        emit saveLaserParamsCompleted(true, "");
    } catch (const std::exception &e) {
        qCritical() << "Failed to save laser params: " << e.what();
        emit saveLaserParamsCompleted(false, e.what());
    }
}


/**
 * @brief Function that loads all the laser parameters from the service
 * and returns them as a QVariantMap.
 * @return QVariantMap - A map that contains key-value pairs for each laser parameter.
 */
QVariantMap LaserParamController::loadLaserParams() {
    // Declare a QVariantMap to store the parameters
    QVariantMap params;

    try {
        // Load parameters from the service
        m_service->loadParams(&laserParam);

        // Populate the QVariantMap with the loaded parameters
        params["laserBeamDiameter"] = laserParam.getLaserBeamDiameter();
        params["pulseFrequency"] = laserParam.getPulseFrequency();
        params["beamShape"] = laserParam.getBeamShape();
        params["assistGas"] = laserParam.getAssistGas();
        params["scanSpeed"] = laserParam.getScanSpeed();
        params["dutyCycle"] = laserParam.getDutyCycle();
        params["spotDiameter"] = laserParam.getSpotDiameter();
        params["focusDistance"] = laserParam.getFocusDistance();
        params["laserPower"] = laserParam.getLaserPower();
        params["laserSpeed"] = laserParam.getLaserSpeed();
        params["focusDepth"] = laserParam.getFocusDepth();
    }
    catch (const std::exception &e) {
        qDebug() << "Failed to load laser parameters: " << e.what();
    }

    // Return the QVariantMap with the parameters (or an empty map if an exception occurred)
    return params;
}
