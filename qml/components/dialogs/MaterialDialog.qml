// Import necessary libraries and components
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs
import QtQuick.Layouts 1.15
import "../../components/shared"
import io.qt.examples.materialController 1.0


// Dialog that will handle the loading params after setting the material , its thickness and which operation we want to apply
Dialog {

    id : materialDialog;
    property var eventBus

    // An instance of materialController to interact with the BE
    MaterialController{
        id: materialController
    }
    property int windowWidth;
    property int windowHeight;

    // Center the dialog in the window
    x: (windowWidth - width)/2;
    y: (windowHeight - height)/2;

    // Properties to store the current value of the combo boxes
    property string materialComboBoxValue: ""
    property string operationComboBoxValue: ""

    property var materials: []

    // Signal that is emitted when the dialog is closed
    signal dialogClosed(var data)



    title: "Load Params";
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
                spacing: 135
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
                    text: materialDialog.title
                    color: "#FFFFFF"
                    font.pixelSize: 20
                    Layout.alignment: Qt.AlignCenter
                    font.bold: true
                }

                Button {
                    topPadding: 15
                    text: "X"
                    font.pixelSize: 20
                    font.bold: true
                    background: Rectangle {
                        color: "transparent"
                    }
                    Layout.alignment: Qt.AlignRight
                    onClicked: materialDialog.close()
                }
            }
        }
    }

    // Components or Message depends on if materials are available
    /*Loader {
        id: componentsLoader
        anchors.fill: parent
        sourceComponent: materials.length > 0 ? contentComponent : noMaterialsComponent
    }*/

    Item {
        id: componentsContainer
        anchors.fill: parent
        Loader {
            id: componentsLoader
            anchors.fill: parent
        }
        Component.onCompleted: {
            materialDialog.materials = materialController.getAllMaterials();

            if(materialDialog.materials.length > 0)
            {
                componentsLoader.sourceComponent = contentComponent;
            }
            else
            {
                componentsLoader.sourceComponent = noMaterialsComponent;
            }
        }

        Component{
            id: contentComponent

            Column{
                spacing: 24

                // Material selection ComboBox
                ComboBoxComponent{
                    id: materialComboBox
                    title : "Material :"
                    boxWidth : 435
                    options: ["mat1", "mat2"]
                    onComboValueChanged: function(value) {
                        materialDialog.materialComboBoxValue = value;
                    }
                    Component.onCompleted: materialComboBox.options = materialDialog.materials.map((_material)=>_material.name)

                }

                // Thickness adjustment Slider
                SliderComponent{
                    id: thicknessSlider
                    title : "Thickness: "
                    sliderWidth: 435
                    unit: "mm"
                    min : 1
                    max : 20
                }

                // Operation selection ComboBox
                ComboBoxComponent{
                    id: operationComboBox
                    title : "Operation :"
                    boxWidth : 435
                    options: ["Cut", "Hatch"]
                    onComboValueChanged: function(value) {
                        materialDialog.operationComboBoxValue = value;
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
                            materialDialog.close()
                        }

                    }
                    Button{
                        width: 102
                        height: 50
                        font.pixelSize: 18

                        contentItem: Label {
                            text: "Apply"
                            font.pixelSize: 18
                            color: "white"
                        }

                        background: Rectangle {
                            color: "#006EA9"
                            radius: 0
                        }

                        onClicked:{
                            try {
                                var currentMat = materialDialog.materials.filter((_material) => _material.name === materialComboBoxValue )

                                // If the current material is not found
                                if (currentMat.length === 0) {
                                    eventBus.sendErrorMessage('Selected material is not found in the list')
                                    throw new Error("Selected material is not found in the list");
                                }

                                var newParams = materialController.calculateParams({
                                                                                       "thickness": thicknessSlider.currentValue,
                                                                                       "operation": operationComboBoxValue,
                                                                                       "material": materialComboBoxValue,
                                                                                       "density": currentMat[0].density
                                                                                   });
                                eventBus.sendSuccessMessage('Saved successfully!')

                                // If new parameters are not calculated correctly
                                if (!newParams) {
                                    eventBus.sendErrorMessage('Failed to calculate new parameters')
                                    throw new Error("Failed to calculate new parameters");
                                }
                                console.log("new Params : ", newParams)
                                dialogClosed(newParams);
                                materialDialog.close()
                            } catch (error) {
                                // Handle any errors that occur
                                eventBus.sendErrorMessage('Failed to Save params')
                                dialogClosed(newParams);
                                console.error("An error occurred: " + error.message);

                            }
                        }
                    }
                }

            }

        }

        Component {
            id: noMaterialsComponent

            Item {
                anchors.centerIn: materialDialog
                Label {
                    text: "There are currently no materials available for selection. Please check back later."
                    width: parent.width - 20
                    font.pixelSize: 20
                    wrapMode: Text.Wrap
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: -50

                }
            }
        }

    }
}
