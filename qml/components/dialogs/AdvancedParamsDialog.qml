// Import necessary libraries and components
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs
import QtQuick.Layouts 1.15
import "../../components/shared"
import io.qt.examples.laserparamcontroller 1.0

// Dialog that will handle the advanced parameters
Dialog {
    id : advancedParamsDialog;

    // An instance of LaserParamController to interact with the laser parameters
    LaserParamController{
        id: laserParamsController
    }

    // Properties for the dialog's position on the screen
    property int windowWidth;
    property int windowHeight;
    property var eventBus

    x: (windowWidth - width)/2;
    y: (windowHeight - height)/2;

    // Properties to store the current value of the combo boxes
    property string beamShapeComboBoxValue: ""
    property string assistGasComboBoxValue: ""

    title: "Advanced Parameters";
    width : 515;
    height : 604;
    background: Rectangle {
        color: "#EBF1F4"
    }

    // Navigation bar header
    header : Item{
        id: navbarSection;
        width : parent.width;
        height: 56;

        // ToolBar with logo and title
        ToolBar{
            anchors.fill:parent;
            background: Rectangle {
                color: "#006EA9"
            }
            RowLayout{
                spacing: 70
                Rectangle{
                    width: 60;
                    height: 49;
                    Image {
                        id: logo;
                        width: 60;
                        height: 49;
                        source: "qrc:/Main/qml/assets/logo.png";
                    }
                }
                Label{
                    topPadding: 15
                    text: advancedParamsDialog.title
                    color: "#FFFFFF"
                    font.pixelSize: 20
                    Layout.alignment: Qt.AlignCenter
                    font.bold: true

                }
            }
        }
    }

    // Layout for sliders and comboboxes
    Column{
        spacing: 24

        // Slider to adjust laser beam diameter
        SliderComponent{
            id: beamDiameterSlider
            title : "Laser Beam Diameter"
            sliderWidth: 435
            unit: "\u00B5"+"m"
            min : 10
            max : 500
        }

        // Slider to adjust pulse frequency
        SliderComponent{
            id: pulseFrequencySlider
            title : "Pulse Frequency"
            sliderWidth: 435
            unit: "KHz"
            min : 1
            max : 100

        }

        // Combobox to select beam shape
        ComboBoxComponent{
            id: beamShapeComboBox
            title : "Beam Shape"
            boxWidth : 435
            options: ["Gaussian", "Top-Hat"]

            onComboValueChanged: function(value) {
                advancedParamsDialog.beamShapeComboBoxValue = value;
            }

        }

        // Combobox to select assist gas
        ComboBoxComponent {
            id: assistGasComboBox
            title: "Assist Gas"
            boxWidth: 435
            options: ["Nitrogen", "Oxygen"]

            onComboValueChanged: function(value) {
                advancedParamsDialog.assistGasComboBoxValue = value
            }
        }

        // Save and Abort buttons
        Row{
            anchors.right: parent.right
            spacing : 37
            Button{
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
                onClicked:{
                    advancedParamsDialog.close()
                }

            }
            Button{
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

                onClicked:{
                    // Validation before save operation
                    if (beamDiameterSlider.currentValue < beamDiameterSlider.min || beamDiameterSlider.currentValue > beamDiameterSlider.max) {
                        console.log("Slider 1 value out of range: " + beamDiameterSlider.currentValue)
                        eventBus.sendErrorMessage('beam diameter out of range')
                        advancedParamsDialog.close()
                        return;
                    }
                    if (pulseFrequencySlider.currentValue < pulseFrequencySlider.min || pulseFrequencySlider.currentValue > pulseFrequencySlider.max) {
                        console.log("Slider 2 value out of range: " + pulseFrequencySlider.currentValue)
                        eventBus.sendErrorMessage('Pulse Frequency out of range')
                        advancedParamsDialog.close()
                        return;
                    }
                    if (beamShapeComboBox.options.indexOf(advancedParamsDialog.beamShapeComboBoxValue) === -1) {
                        console.log("Invalid value for combo box 1: " + advancedParamsDialog.beamShapeComboBoxValue)
                        eventBus.sendErrorMessage('Invalid value for beam shape')
                        advancedParamsDialog.close()
                        return;
                    }
                    if (assistGasComboBox.options.indexOf(advancedParamsDialog.assistGasComboBoxValue) === -1) {
                        console.log("Invalid value for combo box 2: " + advancedParamsDialog.assistGasComboBoxValue)
                        eventBus.sendErrorMessage('Invalid value for Assist gas')
                        advancedParamsDialog.close()
                        return;
                    }
                    try{

                        laserParamsController.saveLaserParams(
                                    {
                                        "laserBeamDiameter": beamDiameterSlider.currentValue,
                                        "pulseFrequency": pulseFrequencySlider.currentValue,
                                        "beamShape": advancedParamsDialog.beamShapeComboBoxValue,
                                        "assistGas": advancedParamsDialog.assistGasComboBoxValue
                                    })

                    }catch(error){
                        console.error("An error occurred: ", error);
                        eventBus.sendErrorMessage('Impossible to save params')

                    }


                    advancedParamsDialog.close()
                }
            }
        }

    }

    // Call loadAdvancedParams when the dialog is created and when it becomes visible
    Component.onCompleted: {
        laserParamsController.saveLaserParamsCompleted.connect(function(success, errorMessage) {
            if (success) {
                eventBus.sendSuccessMessage('Saved successfully!')
            } else {
                eventBus.sendErrorMessage('Impossible to save params')
            }
        })

        // Load parameters from the controller

        // Check if params is empty
        let params = laserParamsController.loadLaserParams();
        if (Object.keys(params).length === 0) {
            console.error("Failed to load parameters. Params is empty.");
            eventBus.sendErrorMessage('Failed to load parameters.')
            return;
        }

        // Set the values for the components
        beamDiameterSlider.currentValue = params["laserBeamDiameter"];
        pulseFrequencySlider.currentValue = params["pulseFrequency"];
        beamShapeComboBox.initialValue = params["beamShape"];
        assistGasComboBox.initialValue = params["assistGas"];
    }




}
