import QtQuick 2.0

Rectangle{
    id:planet
    anchors.top:parent.bottom
    anchors.topMargin: -height/5
    width: parent.width
    height: parent.height
    color: "darkgreen"
    radius: height/2
}
