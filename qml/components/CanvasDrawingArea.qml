import QtQuick 2.0
import "./shared"

Item {
    width: 800
    height: 600

    Canvas {
        id: canvas
        anchors.fill: parent
        contextType: "2d"

        onPaint: {
            var ctx = getContext("2d");
            ctx.strokeStyle = Qt.rgba(1, 0, 0, 1); // color
            ctx.lineWidth = 2; // line width

            // draw path
            ctx.beginPath();
            for (var i in path) {
                var point = path[i];
                if (i === 0) {
                    ctx.moveTo(point.x, point.y);
                } else {
                    ctx.lineTo(point.x, point.y);
                }
            }
            ctx.stroke();
        }
    }

    property var path: []

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        property bool pressedInside: false

        onPressed: {
            path.push({x: mouseX, y: mouseY});
            pressedInside = true;
        }

        onPositionChanged: {
            if (pressedInside) {
                path.push({x: mouseX, y: mouseY});
                canvas.requestPaint();
            }
        }

        onReleased: {
            if (pressedInside) {
                pressedInside = false;
            }
        }
    }
}
