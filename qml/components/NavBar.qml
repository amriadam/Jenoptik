    import QtQuick
    import QtQuick.Controls 2.15
    import QtQuick.Layouts 1.15
    import "./shared"

    ToolBar{
        id: navbarSection;
        property var eventBus
        width : parent.width
        background: Rectangle {
            color: "#006EA9"
        }
        RowLayout{

            Rectangle{
                width: 60;
                height: 49;
                anchors.leftMargin: 30
                Image {
                    id: logo;
                    width: 60;
                    height: 49;
                    source: "qrc:/Main/qml/assets/logo.png";
                }
            }
            Button {
                id: fileNav;
                bottomPadding: 5
                text: "File"
                hoverEnabled: true
                background: Rectangle {
                    color: fileNav.hovered ? "#006398" : "#006EA9"
                }
                onClicked:{fileMenu.open()}
                Menu {
                    id: fileMenu
                    x: fileNav.x - fileNav.width
                    y : fileNav.height

                    MenuItem {
                        text: "New"
                    }
                    MenuItem {
                        text: "Open"
                    }
                    MenuItem {
                        text: "Save"
                    }
                }
            }
            Button {
                id: settingsNav;
                text: "Settings"
                bottomPadding: 5
                hoverEnabled: true
                background: Rectangle {
                    color: settingsNav.hovered ? "#006398" : "#006EA9"
                }
                onClicked:{settingsMenu.open()}
                Menu {
                    id: settingsMenu
                    x: settingsNav.x - settingsNav.width
                    y : settingsNav.height

                    MenuItem {
                        text: "Advanced Settings"
                        onClicked: {
                            console.log("eventBus :", eventBus);
                            console.log("advanced params clicked");
                            var advancedParamsComponent = Qt.createComponent("dialogs/AdvancedParamsDialog.qml");
                            if (advancedParamsComponent.status === Component.Ready) {
                                var dialog = advancedParamsComponent.createObject(mainWindow, {"windowWidth": mainWindow.width, "windowHeight": mainWindow.height , "eventBus": navbarSection.eventBus});
                                dialog.open();
                            } else {
                                console.log("Error loading dialog component:", advancedParamsComponent.errorString());
                            }

                        }

                    }
                    MenuItem {
                        text: "Scan Settings"
                        onClicked: {
                            console.log("scan params clicked");
                            var scanParamscomponent = Qt.createComponent("dialogs/ScanParamsDialog.qml");
                            if (scanParamscomponent.status === Component.Ready) {
                                var dialog = scanParamscomponent.createObject(mainWindow, {"windowWidth": mainWindow.width, "windowHeight": mainWindow.height,"eventBus": navbarSection.eventBus});
                                dialog.open();
                            } else {
                                console.log("Error loading dialog component:", scanParamscomponent.errorString());
                            }

                        }
                    }
                }
            }
            Button {
                id: helpNav
                bottomPadding: 5
                text: "Help"
                hoverEnabled: true
                background: Rectangle {
                    color: helpNav.hovered ? "#006398" : "#006EA9"
                }
                onClicked:{}
            }
        }
    }
