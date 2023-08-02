#include "LaserParam.h"

LaserParam::LaserParam(
    QObject *parent,
    double laserBeamDiameter,
    double pulseFrequency,
    double scanSpeed,
    double spotDiameter,
    double focusDistance,
    double dutyCycle,
    double laserPower,
    double laserSpeed,
    double focusDepth,
    const QString &beamShape,
    const QString &assistGas)
    : QObject(parent)
{
    // Assign the values to the class members here.
    m_laserBeamDiameter = laserBeamDiameter;
    m_pulseFrequency = pulseFrequency;
    m_scanSpeed = scanSpeed;
    m_spotDiameter = spotDiameter;
    m_focusDistance = focusDistance;
    m_dutyCycle = dutyCycle;
    m_laserPower = laserPower;
    m_laserSpeed = laserSpeed;
    m_focusDepth = focusDepth;
    m_beamShape = beamShape;
    m_assistGas = assistGas;
}


LaserParam::~LaserParam()
{
}

// getters
double LaserParam::getLaserBeamDiameter() const { return m_laserBeamDiameter; }
double LaserParam::getPulseFrequency() const { return m_pulseFrequency; }
double LaserParam::getScanSpeed() const { return m_scanSpeed; }
double LaserParam::getSpotDiameter() const { return m_spotDiameter; }
double LaserParam::getFocusDistance() const { return m_focusDistance; }
double LaserParam::getDutyCycle() const { return m_dutyCycle; }
double LaserParam::getLaserPower() const { return m_laserPower; }
double LaserParam::getLaserSpeed() const { return m_laserSpeed; }
double LaserParam::getFocusDepth() const { return m_focusDepth; }
QString LaserParam::getBeamShape() const { return m_beamShape; }
QString LaserParam::getAssistGas() const { return m_assistGas; }

//setters
void LaserParam::setLaserBeamDiameter(double laserBeamDiameter)
{
    if (qFuzzyCompare(m_laserBeamDiameter, laserBeamDiameter))
        return;
    m_laserBeamDiameter = laserBeamDiameter;
    emit laserBeamDiameterChanged(m_laserBeamDiameter);
}

void LaserParam::setPulseFrequency(double pulseFrequency)
{
    if (qFuzzyCompare(m_pulseFrequency, pulseFrequency))
        return;
    m_pulseFrequency = pulseFrequency;
    emit pulseFrequencyChanged(m_pulseFrequency);
}

void LaserParam::setScanSpeed(double scanSpeed)
{
    if (qFuzzyCompare(m_scanSpeed, scanSpeed))
        return;
    m_scanSpeed = scanSpeed;
    emit scanSpeedChanged(m_scanSpeed);
}

void LaserParam::setSpotDiameter(double spotDiameter)
{
    if (qFuzzyCompare(m_spotDiameter, spotDiameter))
        return;
    m_spotDiameter = spotDiameter;
    emit spotDiameterChanged(m_spotDiameter);
}

void LaserParam::setFocusDistance(double focusDistance)
{
    if (qFuzzyCompare(m_focusDistance, focusDistance))
        return;
    m_focusDistance = focusDistance;
    emit focusDistanceChanged(m_focusDistance);
}

void LaserParam::setDutyCycle(double dutyCycle)
{
    if (qFuzzyCompare(m_dutyCycle, dutyCycle))
        return;
    m_dutyCycle = dutyCycle;
    emit dutyCycleChanged(m_dutyCycle);
}

void LaserParam::setLaserPower(double laserPower)
{
    if (qFuzzyCompare(m_laserPower, laserPower))
        return;
    m_laserPower = laserPower;
    emit laserPowerChanged(m_laserPower);
}

void LaserParam::setLaserSpeed(double laserSpeed)
{
    if (qFuzzyCompare(m_laserSpeed, laserSpeed))
        return;
    m_laserSpeed = laserSpeed;
    emit laserSpeedChanged(m_laserSpeed);
}

void LaserParam::setFocusDepth(double focusDepth)
{
    if (qFuzzyCompare(m_focusDepth, focusDepth))
        return;
    m_focusDepth = focusDepth;
    emit focusDepthChanged(m_focusDepth);
}

void LaserParam::setBeamShape(const QString &beamShape)
{
    if (m_beamShape == beamShape)
        return;
    m_beamShape = beamShape;
    emit beamShapeChanged(m_beamShape);
}

void LaserParam::setAssistGas(const QString &assistGas)
{
    if (m_assistGas == assistGas)
        return;
    m_assistGas = assistGas;
    emit assistGasChanged(m_assistGas);
}
QString LaserParam::toString() const {
    return QString("LaserBeamDiameter: %1, PulseFrequency: %2, ScanSpeed: %3, SpotDiameter: %4, FocusDistance: %5, DutyCycle: %6, LaserPower: %7, LaserSpeed: %8, FocusDepth: %9, BeamShape: %10, AssistGas: %11")
        .arg(m_laserBeamDiameter)
        .arg(m_pulseFrequency)
        .arg(m_scanSpeed)
        .arg(m_spotDiameter)
        .arg(m_focusDistance)
        .arg(m_dutyCycle)
        .arg(m_laserPower)
        .arg(m_laserSpeed)
        .arg(m_focusDepth)
        .arg(m_beamShape)
        .arg(m_assistGas);
}
