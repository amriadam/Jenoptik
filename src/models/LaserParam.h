// Include guard to prevent double declaration of the LaserParam class
#ifndef LASERPARAM_H
#define LASERPARAM_H

#include <QObject>

// LaserParam class which inherits from QObject class
class LaserParam : public QObject
{
    // Q_OBJECT macro is necessary for any object that uses signals or slots.
    Q_OBJECT

    // Q_PROPERTY macros define properties for this class that can be accessed
    // using Qt's Meta-Object system. The READ and WRITE keywords specify getter
    // and setter methods for the properties, and NOTIFY specifies a signal that
    // gets emitted when the property changes.
    Q_PROPERTY(double laserBeamDiameter READ getLaserBeamDiameter WRITE setLaserBeamDiameter NOTIFY laserBeamDiameterChanged)
    Q_PROPERTY(double pulseFrequency READ getPulseFrequency WRITE setPulseFrequency NOTIFY pulseFrequencyChanged)
    Q_PROPERTY(double scanSpeed READ getScanSpeed WRITE setScanSpeed NOTIFY scanSpeedChanged)
    Q_PROPERTY(double spotDiameter READ getSpotDiameter WRITE setSpotDiameter NOTIFY spotDiameterChanged)
    Q_PROPERTY(double focusDistance READ getFocusDistance WRITE setFocusDistance NOTIFY focusDistanceChanged)
    Q_PROPERTY(double dutyCycle READ getDutyCycle WRITE setDutyCycle NOTIFY dutyCycleChanged)
    Q_PROPERTY(double laserPower READ getLaserPower WRITE setLaserPower NOTIFY laserPowerChanged)
    Q_PROPERTY(double laserSpeed READ getLaserSpeed WRITE setLaserSpeed NOTIFY laserSpeedChanged)
    Q_PROPERTY(double focusDepth READ getFocusDepth WRITE setFocusDepth NOTIFY focusDepthChanged)
    Q_PROPERTY(QString beamShape READ getBeamShape WRITE setBeamShape NOTIFY beamShapeChanged)
    Q_PROPERTY(QString assistGas READ getAssistGas WRITE setAssistGas NOTIFY assistGasChanged)

public:
    explicit LaserParam(
                        QObject *parent = nullptr,
                        double laserBeamDiameter = 0,
                        double pulseFrequency = 0,
                        double scanSpeed = 0,
                        double spotDiameter = 0,
                        double focusDistance = 0,
                        double dutyCycle = 0,
                        double laserPower = 0,
                        double laserSpeed = 0,
                        double focusDepth = 0,
                        const QString &beamShape = "",
                        const QString &assistGas = ""
                        );
    virtual ~LaserParam();

    // Getter and setter method declarations for each property.

    double getLaserBeamDiameter() const;
    void setLaserBeamDiameter(double laserBeamDiameter);

    double getPulseFrequency() const;
    void setPulseFrequency(double pulseFrequency);

    double getScanSpeed() const;
    void setScanSpeed(double scanSpeed);

    double getSpotDiameter() const;
    void setSpotDiameter(double spotDiameter);

    double getFocusDistance() const;
    void setFocusDistance(double focusDistance);

    double getDutyCycle() const;
    void setDutyCycle(double dutyCycle);

    double getLaserPower() const;
    void setLaserPower(double laserPower);

    double getLaserSpeed() const;
    void setLaserSpeed(double laserSpeed);

    double getFocusDepth() const;
    void setFocusDepth(double focusDepth);

    QString getBeamShape() const;
    void setBeamShape(const QString &beamShape);

    QString getAssistGas() const;
    void setAssistGas(const QString &assistGas);

    QString toString() const;


signals:
    void laserBeamDiameterChanged(double laserBeamDiameter);
    void pulseFrequencyChanged(double pulseFrequency);
    void scanSpeedChanged(double scanSpeed);
    void spotDiameterChanged(double spotDiameter);
    void focusDistanceChanged(double focusDistance);
    void dutyCycleChanged(double dutyCycle);
    void laserPowerChanged(double laserPower);
    void laserSpeedChanged(double laserSpeed);
    void focusDepthChanged(double focusDepth);
    void beamShapeChanged(const QString &beamShape);
    void assistGasChanged(const QString &assistGas);

private:
    double m_laserBeamDiameter;
    double m_pulseFrequency;
    double m_scanSpeed;
    double m_spotDiameter;
    double m_focusDistance;
    double m_dutyCycle;
    double m_laserPower;
    double m_laserSpeed;
    double m_focusDepth;
    QString m_beamShape;
    QString m_assistGas;

};

#endif // LASERPARAM_H
