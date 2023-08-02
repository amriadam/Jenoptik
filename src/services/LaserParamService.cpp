#include "laserparamservice.h"
#include <QSettings>
#include <QDebug>


LaserParamService::LaserParamService(QObject *parent)
    : QObject(parent)
{
}

LaserParamService::~LaserParamService()
{
}

/**
 * @brief Load parameters for a given laser model from application settings
 *
 * This function retrieves saved laser parameters from application settings and sets these values
 * to the passed LaserParam model object. In case any value is not already saved, default values are used.
 * The function also includes error handling for any issues in loading settings.
 *
 * @param model A pointer to LaserParam object where the loaded parameters will be set
 */

void LaserParamService::loadParams(LaserParam* model)
{
    if(model == nullptr) // Check if the passed model is not a null pointer
    {
        qCritical() << "The provided model is a null pointer. Cannot load parameters.";
        return;
    }
    QSettings settings("Jenoptik", "MyLaserApp");

    settings.beginGroup("LaserParams");

    // Load params for model from settings with error handling
    // auto for type dedeuction
    //The lambda function is capturing the settings object by reference using [&settings]
    auto loadParam = [&settings](const QString& key, auto defaultValue) {
        if(settings.contains(key))
            return settings.value(key).value<decltype(defaultValue)>();
        else
        {
            qWarning() << "No value found for key" << key << "in settings. Using default value";
            return defaultValue;
        }
    };

    model->setLaserBeamDiameter(loadParam("laserBeamDiameter",12.0));
    model->setPulseFrequency(loadParam("pulseFrequency",50.0));
    model->setBeamShape(loadParam("beamShape",QString("Gaussian")));
    model->setAssistGas(loadParam("assistGas",QString("Nitrogen")));

    model->setScanSpeed(loadParam("scanSpeed",1.0));
    model->setDutyCycle(loadParam("dutyCycle",100.0));
    model->setSpotDiameter(loadParam("spotDiameter",500.0));
    model->setFocusDistance(loadParam("focusDistance",500.0));

    model->setLaserPower(loadParam("laserPower",1000.0));
    model->setLaserSpeed(loadParam("laserSpeed",200.0));
    model->setFocusDepth(loadParam("focusDepth",170.0));

    settings.endGroup();
    if (settings.status() != QSettings::NoError) {
        qCritical() << "Failed to load advanced settings";
    }
}

/**
 * @brief Saves the laser parameters from the provided model to the application settings
 *
 * @param model A constant pointer to a LaserParam object from which the parameters will be saved
 */
void LaserParamService::saveParams(const LaserParam* model)
{
    // Define the QSettings object to access application settings
    QSettings settings("Jenoptik", "MyLaserApp");

    // Check if the settings file is writable
    if (!settings.isWritable()) {
        qCritical() << "Settings are not writable.";
        return;
    }

    // Begin the settings group for laser parameters
    settings.beginGroup("LaserParams");

    // Define a lambda function to save the parameters to the settings
    auto saveParam = [&settings](const QString& key, auto value, auto defaultValue) {
        if (value != defaultValue) {
            settings.setValue(key, value);
        }
        else {
            qWarning() << "Default value for" << key << "not saved to settings.";
        }
    };

    // Save parameters using the lambda function
    saveParam("laserPower", model->getLaserPower(), -1.0);
    saveParam("laserSpeed", model->getLaserSpeed(), -1.0);
    saveParam("focusDepth", model->getFocusDepth(), -1.0);
    saveParam("laserBeamDiameter", model->getLaserBeamDiameter(), -1.0);
    saveParam("pulseFrequency", model->getPulseFrequency(), -1.0);
    saveParam("beamShape", model->getBeamShape(), QString("none"));
    saveParam("assistGas", model->getAssistGas(), QString("none"));
    saveParam("scanSpeed", model->getScanSpeed(), -1.0);
    saveParam("dutyCycle", model->getDutyCycle(), -1.0);
    saveParam("spotDiameter", model->getSpotDiameter(), -1.0);
    saveParam("focusDistance", model->getFocusDistance(), -1.0);

    // End the settings group
    settings.endGroup();

    // Sync data to storage
    settings.sync();

    if (settings.status() != QSettings::NoError) {
        qCritical() << "Failed to save settings";
    }
}
