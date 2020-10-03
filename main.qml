import QtQuick 2.14
import QtQuick.Window 2.14

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("LD47 - Stuck in a loop")

    Rectangle{
        anchors.fill: parent
        color: "black"
    }
    Image{
        id:dormammu
        anchors.fill: parent
        source: "images/dormammu.png"
    }

    Planet{
        id:planet
        Player{
            id:player
            x:parent.width/2-width/2
        }
    }
    MouseArea{
        anchors.fill: parent
        property int lastX
        property int lastY
        onPressed: {
            lastX=mouse.x
            lastY=mouse.y
        }
        onMouseXChanged: {
            if(mouseX>lastX)
                player.x+=player.velocity
            if(mouseX<lastX)
                player.x-=player.velocity
            lastX=mouseX
        }
        onMouseYChanged: {
            if(mouseY>lastY)
                player.y+=player.velocity
            if(mouseY<lastY)
                player.y-=player.velocity
            lastY=mouseY
        }
    }
}
