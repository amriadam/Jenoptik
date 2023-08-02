import QtQuick 2.15

Item {
    id: root
    width: 300
    height: 40
    visible: true
    property var parentHeight
    property string message: ""
    property string color  : ""
    y : parentHeight -100
    Rectangle {
        id: toast
        width: parent.width
        height: parent.height
        color: root.color
        radius: 10
        anchors.horizontalCenter: parent.horizontalCenter
        //y: (root.parentHeight-100)
        opacity: 0.0
        state: "hidden"

        Text {
            id: toastText
            text: root.message
            color: "white"
            font.pixelSize: 15
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
            wrapMode: Text.WordWrap
            width: toast.width - 20
        }

        onStateChanged: {
            if (state === "shown") {
                opacity = 1.0

            }

        }
    }
    Timer {
        id: autoCloseTimer
        interval: 1000
        running: false
        repeat: false
        onTriggered: {
            toast.opacity = 0.0;
            root.visible = false;
            toast.state = "hidden"
        }
    }

    function showMessage(msg,type) {
        console.log("type" , type);
        if(type === "success"){
            root.color = "#19B216"
        }
        else
            root.color = "#FF0000"

        root.message = msg;
        toast.state = 'shown'
        root.visible = true
        console.log('signal come')
        autoCloseTimer.restart();
    }


}
