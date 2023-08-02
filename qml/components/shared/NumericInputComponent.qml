import QtQuick 2.12
import QtQuick.Controls 2.15

Rectangle {
    width : text.width+spinBox.width + 10
    height : Math.max(text.height,spinBox.height)
    color: "transparent"
    property string myText: ""
    Row{
        spacing : 10
        Text {
            id : text
            text: myText
            color: "#006EA9"
        }

        SpinBox {
            id: spinBox
            from: 0
            to: 100
            value: 50
            stepSize: 1
            width: 100
            height : 30

        }

    }


}
