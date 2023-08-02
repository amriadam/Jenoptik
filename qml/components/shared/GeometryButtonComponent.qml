import QtQuick 2.12

Rectangle {
    property string mytext: ""
    property string iconPath: ""
    property int borderW: 0

    border.width : borderW
    border.color: "#006EA9"

    color: mouseArea.containsMouse ? "#CCCCCC" : "transparent"; // Change color when hovered



    Image {
        id: icon
        source: iconPath
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        height: 23
        width: 23
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: buttonText
        text: mytext
        color: "#006EA9"
        anchors.left: icon.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 16
    }
    width: buttonText.width + icon.width + buttonText.anchors.leftMargin
    height: Math.max(icon.height, buttonText.height)

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true // Enable the hover state

        onClicked: {
            // Add your click handler code here
            console.log("Button clicked")
        }

    }
}
