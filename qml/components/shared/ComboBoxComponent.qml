import QtQuick 2.12
import QtQuick.Controls 2.5

Item{
    id : myCompoBoxComponent

    property string initialValue : "Gaussian"
    property string title: "myTitle"
    property int boxWidth: 400
    property var options: []


    signal comboValueChanged(string value)


    height : column.height
    width : boxWidth
    Column {
        id: column
        spacing: 15
        Text {
            id: myText
            text: title
            font.pixelSize: 16
            color: "black"
        }

        ComboBox {
            id: myComboBox
            width: boxWidth
            model:  options
            Material.foreground: "#006EA9"
            Material.background: "#CCE2EE"
            Material.accent: "#006EA9"
            Material.primary: "#006EA9"


            Component.onCompleted: {
                var initialValue = myCompoBoxComponent.initialValue;
                var index = options.indexOf(initialValue);
                if (index != -1) {
                    currentIndex = index;
                }
            }


            onCurrentTextChanged: {
                console.log("Current option: " + myComboBox.currentText);
                myCompoBoxComponent.comboValueChanged(myComboBox.currentText);
            }

        }


    }

}
