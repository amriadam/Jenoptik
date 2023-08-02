import QtQuick 2.12
import QtQuick.Controls 2.5

Item {

    id: mySliderComponent
    property alias currentValue: mySlider.value

    property string title: "myTitle"
    property int sliderWidth: 400
    property string unit : "myUnit"
    property int min : 0;
    property int max : 100;
    property int stepSize : 1

    width: sliderWidth
    height : column.height
    Column {
        id: column
        spacing: 15

        Text {
            id: myText
            text: title
            font.pixelSize: 16
            color: "black"
        }

        Slider {
            id: mySlider
            width: sliderWidth
            from: min
            to: max
            value: currentValue
            stepSize: stepSize


            onValueChanged: {
                console.log("Slider value: " + value)
            }

            background: Rectangle {
                implicitWidth: 200
                height: 8
                color: "#D4D2D2"
                radius: 4

                Rectangle {
                    width: mySlider.visualPosition * parent.width
                    height: 8
                    color: "#006EA9"
                    radius: 4
                }
            }

            handle: Rectangle {
                x: mySlider.visualPosition * (mySlider.availableWidth - width)
                y : -5
                width: 22
                height: 22
                color: mySlider.pressed ? "#006EA9" : "#D9D9D9"
                radius: 8
            }
            Label {
                text: Number(mySlider.value).toFixed(2)  + unit
                anchors{
                    bottom: mySlider.top

                }
                x: mySlider.width - 40
                font.pixelSize: 12
                color: "#006EA9"
            }

        }


    }
}
