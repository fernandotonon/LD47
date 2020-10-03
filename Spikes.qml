import QtQuick 2.15

Item {
    width: parent.width/150+1
    height: parent.height/20+2

    Item{
        id:spikes
        anchors.fill: parent
        visible: false
        Spike{
            id:spike
        }
        Spike{
            id:spike1
            rotation: 40
        }
        Spike{
            id:spike2
            rotation: -40
        }

        onVisibleChanged: {
            spike1.rotation=Math.random()*30+10
            spike2.rotation=Math.random()*-30-10
        }
    }

    Rectangle{
        x:-width/2
        width: parent.height
        height: parent.height
        radius:parent.height/2
        color: "red"
        onVisibleChanged: spikes.visible=!visible
        Timer{
            interval: 1000
            repeat: true
            running: true
            onTriggered: {
                parent.visible=!parent.visible
            }
        }
    }

}
