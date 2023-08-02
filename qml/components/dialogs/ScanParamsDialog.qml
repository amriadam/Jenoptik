import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs
import QtQuick.Layouts 1.15
import "../../components/shared"
import io.qt.examples.laserparamcontroller 1.0

// Dialog for managing scan parameters
Dialog {
    id : scanParamsDialog;

    // An instance of LaserParamController to interact with the laser parameters
    LaserParamController{
        id: laserParamsController
    }

    // Dynamic properties to center the dialog window
    property int windowWidth;
    property int windowHeight;


    property var eventBus


    // Dynamic properties to center the dialog window
    x: (windowWidth - width)/2;
    y: (windowHeight - height)/2;

    title: "Scan Params";
    width : 515;
    height : 604;

    // Background of the dialog window
    background: Rectangle {
        color: "#EBF1F4"
    }

    // Header section of the dialog window
    header : Item {
        id: navbarSection;
        width : parent.width;
        height: 56;

        // The toolbar contains the logo and title of the dialog
        ToolBar {
            anchors.fill: parent;
            background: Rectangle {
                color: "#006EA9"
            }

            // Layout for the logo and title of the dialog
            RowLayout {
                spacing: 70
                Rectangle {
                    width: 60;
                    height: 49;

                    // Logo of the dialog
                    Image {
                        id: logo;
                        width: 60;
                        height: 49;
                        source: "qrc:/Main/qml/assets/logo.png";
                    }
                }

                // Title of the dialog
                Label {
                    topPadding: 15
                    text: scanParamsDialog.title
                    color: "#FFFFFF"
                    font.pixelSize: 20
                    Layout.alignment: Qt.AlignCenter
                    font.bold: true

                }
            }
        }
    }

    // Main content of the dialog window
    Column {
        spacing: 30

        // Sliders for the scan parameters
        // Each SliderComponent instance represents a scan parameter

        // Scan Speed Slider
        SliderComponent {
            id: scanSpeedSlider
            title : "Scan speed"
            sliderWidth: 435
            unit: "mm/s"
            min : 1
            max : 5000
        }

        // Duty Cycle Slider
        SliderComponent {
            id: dutyCycleSlider
            title : "Duty Cycle"
            sliderWidth: 435
            unit: "%"
            min : 0
            max : 100
        }

        // Spot Diameter Slider
        SliderComponent {
            id: spotDiameterSlider
            title : "Spot Diameter"
            sliderWidth: 435
            unit: "\u00B5"+"m"
            min : 1
            max : 500
        }

        // Focus Distance Slider
        SliderComponent {
            id: focusDistanceSlider
            title : "Focus Distance"
            sliderWidth: 435
            unit: "mm"
            min : 1
            max : 500
        }

        // Buttons for aborting or saving changes to scan parameters
        Row {
            anchors.right: parent.right
            spacing : 37

            // Abort button
            Button {
                width: 102
                height: 50
                font.pixelSize: 18

                contentItem: Label {
                    text: "Abort"
                    font.pixelSize: 18
                    color: "#006EA9"
                }

                background: Rectangle {
                    color: "#CCE2EE"
                    radius: 0
                }

                onClicked: {
                    // Close the dialog when abort button is clicked
                    scanParamsDialog.close()
                }
            }

            // Save button
            Button {
                width: 102
                height: 50
                font.pixelSize: 18

                contentItem: Label {
                    text: "Save"
                    font.pixelSize: 18
                    color: "white"
                }

                background: Rectangle {
                    color: "#006EA9"
                    radius: 0
                }

                onClicked: {
                    // Save the current values of the sliders
                    try {
                        laserParamsController.saveLaserParams(
                                    {
                                        "scanSpeed": scanSpeedSlider.currentValue,
                                        "dutyCycle": dutyCycleSlider.currentValue,
                                        "spotDiameter": spotDiameterSlider.currentValue,
                                        "focusDistance": focusDistanceSlider.currentValue
                                    })
                        scanParamsDialog.close()

                    }catch (error) {
                        console.error("An error occurred while saving the laser parameters: ", error);
                        eventBus.sendErrorMessage('Impossible to save params')
                        scanParamsDialog.close()

                    }
                }
            }
        }
    }

    Component.onCompleted: {

        laserParamsController.saveLaserParamsCompleted.connect(function(success, errorMessage) {
            if (success) {
                eventBus.sendSuccessMessage('Saved successfully!')
            } else {
                eventBus.sendErrorMessage('Impossible to save params')
            }
        })

        console.log("Window dimensions are: ", windowHeight, windowWidth)
        // Load parameters from the controller
        try {
            let params = laserParamsController.loadLaserParams();


            // Set the values for the components
            scanSpeedSlider.currentValue = params["scanSpeed"];
            dutyCycleSlider.currentValue = params["dutyCycle"];
            spotDiameterSlider.currentValue = params["spotDiameter"];
            focusDistanceSlider.currentValue = params["focusDistance"];
        } catch (error) {
            console.error("An error occurred while loading the laser parameters: ", error);
        }
    }
}
