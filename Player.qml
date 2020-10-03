import QtQuick 2.0

Rectangle {
    width: 20
    height: 60
    color: "red"
    focus: true
    radius:4
    property int velocity:10
    property bool started:false
    Rectangle {
        width: 5
        height: 5
        color: "lightgreen"
        radius:width/2
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -10
    }

    Keys.onUpPressed: y-=velocity
    Keys.onDownPressed: y+=velocity
    Keys.onLeftPressed: x-=velocity
    Keys.onRightPressed: x+=velocity

    onXChanged: {
        if(started){
        if(x<parent.width/5)
            x=parent.width/5
        else if(x+width>parent.width-parent.width/5)
            x=parent.width-parent.width/5-width
        }
    }
    onYChanged: {
        if(started){
        if(y<-height/2)
            y=-height/2
        else if(y+height>parent.height/5)
            y=parent.height/5-height
        }
    }
    Component.onCompleted: started=true
}
