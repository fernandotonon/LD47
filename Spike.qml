import QtQuick 2.0
import QtQuick.Shapes 1.15

Shape {
    id:spike
    width: parent.width
    height: parent.height

    NumberAnimation on height{
        from:0
        to: height
        duration:500
        running: true
        loops: -1
    }
    NumberAnimation on y{
        from: height
        to: 0
        duration:500
        running: true
        loops: -1
    }

    ShapePath {
        strokeColor:"transparent"
            fillGradient: LinearGradient {
                x1:0; y1:0
                x2:0; y2:spike.height
                GradientStop { position: 0; color: "blue" }
                GradientStop { position: 0.4; color: "red" }
                GradientStop { position: 0.6; color: "yellow" }
                GradientStop { position: 1; color: "cyan" }
            }
            startX: 0; startY: 0
            PathLine { x: spike.width/2; y: 0 }
            PathLine { x: spike.width; y: spike.height}
            PathLine { x: 0; y: spike.height }
            PathLine { x: spike.width/2; y: 0 }
        }

}
