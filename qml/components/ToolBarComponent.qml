import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./shared"

Row{
    id : toolsSection;
    width: parent.width;
    spacing :110
    anchors.top: navbarSection.bottom;
    anchors.topMargin: 15;
    /*-------------Laser Control Section Start ------------- */

    Column{
        anchors.topMargin:  0;
        id:laserControlSection;
        Text{
            id : laserControlTitle;
            text: "Laser Control";
            color : "#9FACBD";
            leftPadding: 126;
            bottomPadding: 15;
            y: -15
        }
        Item{
            anchors{
                top : laserControlTitle.bottom;
                leftMargin: 81;
            }
            x: 81;
            RoundButtonComponent{
                icon : "qrc:/Main/qml/assets/playIcon.png"
                bgColor : "#19B216"
                mytext : "Play"
            }

        }
        Item{
            anchors{
                top : laserControlTitle.bottom;
                leftMargin: 81;
            }
            x: 165;

            RoundButtonComponent{
                icon : "qrc:/Main/qml/assets/pauseIcon.png"
                bgColor : "#006EA9"
                mytext : "Pause"
            }


        }
        Item{
            anchors{
                top : laserControlTitle.bottom;
                leftMargin: 81;
            }
            x: 249;
            RoundButtonComponent{
                icon : "qrc:/Main/qml/assets/stopIcon.png"
                bgColor : "#FF0000"
                mytext : "Stop"
            }
        }
    }

    /*-------------Laser Control Section end ------------- */

    //----------------------vertical seperator------------
    Rectangle {
        width: 1
        height: parent.height
        color: "#D9D9D9"
    }

    //----------------------vertical seperator------------

    /*-------------Geometry Section Start ------------- */
    Column{
        anchors.topMargin:  0
        id:geometrySection;

        Text{
            id : geometrySectionTitle;
            text: "Geometry";
            color : "#9FACBD";
            leftPadding: 70;
            bottomPadding: 15;

        }

        Row{
            spacing: 15
            Column{
                spacing: 15
                GeometryButtonComponent{
                    mytext : "Line"
                    iconPath : "qrc:/Main/qml/assets/line.png"
                }
                GeometryButtonComponent{
                    mytext : "Rectangle"
                    iconPath : "qrc:/Main/qml/assets/rectangle.png"
                }
                GeometryButtonComponent{
                    mytext : "Circle"
                    iconPath : "qrc:/Main/qml/assets/circle.png"
                }
            }
            Column{
                spacing: 15
                GeometryButtonComponent{
                    mytext : "Polygone"
                    iconPath : "qrc:/Main/qml/assets/polygone.png"
                }
                GeometryButtonComponent{
                    mytext : "Text"
                    iconPath : "qrc:/Main/qml/assets/text.png"
                }
                GeometryButtonComponent{
                    mytext : "More "
                    iconPath : "qrc:/Main/qml/assets/more.png"
                    borderW : 1
                }
            }
        }
    }
    /*-------------Geometry Section end ------------- */

    //----------------------vertical seperator------------
    Rectangle {
        width: 1
        height: parent.height
        color: "#D9D9D9"
    }

    //----------------------vertical seperator------------

    /*-------------View Section start ------------- */
    Column{
        anchors.topMargin:  0
        id:viewSection;

        Text{
            id : viewSectionTitle;
            text: "View";
            color : "#9FACBD";
            leftPadding: 70;
            bottomPadding: 15;

        }

        Row{
            spacing: 15
            Column{
                spacing: 15
                GeometryButtonComponent{
                    mytext : "Zoom In"
                    iconPath : "qrc:/Main/qml/assets/zoomIn.png"
                }
                GeometryButtonComponent{
                    mytext : "Zoom Out"
                    iconPath : "qrc:/Main/qml/assets/zoomOut.png"
                }

            }
            Column{
                spacing: 15
                GeometryButtonComponent{
                    mytext : "2D View"
                    iconPath : "qrc:/Main/qml/assets/2D.png"
                }
                GeometryButtonComponent{
                    mytext : "3D View"
                    iconPath : "qrc:/Main/qml/assets/3D.png"
                }

            }
        }
    }
    /*-------------View Section end ------------- */

    //----------------------vertical seperator------------
    Rectangle {
        width: 1
        height: parent.height
        color: "#D9D9D9"
    }

    //----------------------vertical seperator------------

    /*-------------Shapes Conf Section start ------------- */
    Column{
        anchors.topMargin:  0
        id: shapesConfSection;

        Text{
            id : shapesConfSectionTitle;
            text: "Shapes Configuration";
            color : "#9FACBD";
            leftPadding: 110;
            bottomPadding: 15;

        }
        Column{
            spacing: 15
            Row{
                spacing: 15

                NumericInputComponent {
                    myText: "X position"
                }

                NumericInputComponent {
                    myText: "Width"
                }
                NumericInputComponent {
                    myText: "Rotate"
                }
            }
            Row{
                spacing: 15

                NumericInputComponent {
                    myText: "Y position"
                }

                NumericInputComponent {
                    myText: "Height"
                }


            }
        }


    }
    /*-------------Shapes Conf Section end ------------- */





}
