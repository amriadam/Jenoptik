import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./shared"
import io.qt.examples.laserparamcontroller 1.0

Rectangle  {
    id : sideBar
    property var eventBus

    LaserParamController{
        id: laserParamsController
    }
    y : 240
    x : 32
    width : 327
    height: parent.height
    color: "white"
    Column {
        spacing: 24

        Rectangle{
            id : laserParamsTitle
            width : sideBar.width
            color : "#CCE2EE"
            height : 41
            Text {
                text: "Laser Prameters"
                anchors.centerIn: laserParamsTitle
                color: "#398FBC"
                font.bold: true
            }
        }

        SliderComponent{
            anchors.horizontalCenter:   parent.horizontalCenter
            id: laserPowerSlider
            title : "Laser Power"
            sliderWidth: 250
            unit: "W"
            min : 0
            max : 5000
        }
        SliderComponent{
            anchors.horizontalCenter:   parent.horizontalCenter
            id: laserSpeedSlider
            title : "Laser Speed"
            sliderWidth: 250
            unit: "mm/s"
            min : 1
            max : 500
        }
        SliderComponent{
            anchors.horizontalCenter:   parent.horizontalCenter
            id: focusDepthSlider
            title : "Focus Depth"
            sliderWidth: 250
            unit: "mm"
            min : 1
            max : 50
        }
        Row{
            anchors.horizontalCenter:   parent.horizontalCenter
            spacing  : 20

            Button{
                id : loadButton
                height: 50
                font.pixelSize: 18

                contentItem: Label {
                    text: "Load Params"
                    font.pixelSize: 18
                    color: "#006EA9"
                }
                hoverEnabled: true
                background: Rectangle {
                    color: loadButton.hovered ? "#b7cbd6" : "#CCE2EE"
                }


                onClicked:{

                    var materialDialogComponent = Qt.createComponent("dialogs/MaterialDialog.qml");
                    if (materialDialogComponent.status === Component.Ready) {
                        var dialog = materialDialogComponent.createObject(mainWindow, {"windowWidth": mainWindow.width, "windowHeight": mainWindow.height,"eventBus": navbarSection.eventBus});

                        dialog.dialogClosed.connect(function(data) {
                            laserPowerSlider.currentValue = data.laserPower;
                            laserSpeedSlider.currentValue = data.laserSpeed;
                            focusDepthSlider.currentValue = data.focusDepth;
                        });


                        dialog.open();
                    } else {
                        console.log("Error loading dialog component:", materialDialogComponent.errorString());
                    }

                }
            }
            Button{
                id : saveButton
                width: 90
                height: 50
                font.pixelSize: 18

                contentItem: Label {
                    text: "Save"
                    font.pixelSize: 18
                    color: "white"
                }
                hoverEnabled: true
                background: Rectangle {
                    color: saveButton.hovered ? "#006398" : "#006EA9"
                }


                onClicked:{
                    try {
                        laserParamsController.saveLaserParams(
                                    {
                                        "laserPower": laserPowerSlider.currentValue,
                                        "laserSpeed": laserSpeedSlider.currentValue,
                                        "focusDepth": focusDepthSlider.currentValue,
                                    })
                    } catch (err) {
                        console.error("An error occurred: ", err);
                        eventBus.sendErrorMessage('An error occured while saving ')

                    }


                }
            }
        }



        Rectangle{
            id : layersTitle
            width : sideBar.width
            color : "#CCE2EE"
            height : 41
            Text {
                text: "Layers / Cuts"
                anchors.centerIn: layersTitle
                color: "#398FBC"
                font.bold: true
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
        try {

            let params = laserParamsController.loadLaserParams();
            if (Object.keys(params).length === 0) {
                console.error("Failed to load parameters. Params is empty.");
                eventBus.sendErrorMessage('Failed to load parameters.')
                return;
            }
            // Set the values for the components
            laserPowerSlider.currentValue = params["laserPower"];
            laserSpeedSlider.currentValue = params["laserSpeed"];
            focusDepthSlider.currentValue = params["focusDepth"];
        }catch (error) {
            console.error("An error occurred while loading the laser parameters: ", error);
            eventBus.sendErrorMessage('Failed to load parameters.')
        }
    }



}
