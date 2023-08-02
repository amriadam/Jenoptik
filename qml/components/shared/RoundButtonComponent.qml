import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    property string icon: ""
    property string bgColor : "white"
    property string mytext : "text"
    Rectangle{
        id: roundButton;
        width: 45;
        height: 45;
        radius: width / 2;
        color: bgColor
        Image {
            anchors.centerIn: parent;
            source: icon;
            width: 24.34 ;
            height: 26.56 ;
        }
    }
    Text {
        anchors{
            horizontalCenter: roundButton.horizontalCenter
            top: roundButton.bottom;
        }
        text: mytext;
        color : "#006EA9";
        height: 16;
    }
}
