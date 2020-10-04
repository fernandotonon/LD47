import QtQuick 2.14
import QtQuick.Window 2.14
import QtMultimedia 5.15

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("LD47 - Stuck in a loop")
    property int level:dodges/10+1
    property int dodges:0
    property int loops:0
    property var spikeArray: []

    onLevelChanged: createSpike()

    SoundEffect{
        id:deathSFX
        source: "/SFX/uargh.wav"
    }

    function createSpike(){
        var component = Qt.createComponent("Spikes.qml")
        var obj = component.createObject(planet,{targetObj:player})
        obj.onTrackingChanged.connect((t)=>{if(!obj.tracking)dodges-=-1})
        obj.touch.connect(()=>{
                              reset()
                              deathSFX.play()
                          })
        spikeArray.push(obj)
    }

    function reset(){
        for(var s in spikeArray){
            spikeArray.pop().destroy()
        }
        dodges=0
        loops-=-1
        bargainScreen.visible=true
        if(spikeArray.length==0)
            createSpike()
    }

    Item{
        visible: !bargainScreen.visible
        anchors.fill: parent
        Rectangle{
            anchors.fill: parent
            color: "black"
        }
        Image{
            id:dormammu
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
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

        Text{
            text:"Dodges: "+dodges
            color: "white"
            font.pixelSize: player.height/4
            font.bold: true
        }
    }

    Rectangle{
        id:bargainScreen
        anchors.fill: parent
        color: "white"
        SoundEffect{
            id:ctbSFX
            source: "/SFX/come_to_bargain.wav"
        }

        Image {
            anchors.fill: parent
            source: "/images/strange.png"
        }
        Text {
            id:bLabel
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -bargainScreen.height/3
            text: qsTr("Dormammu, I've come to Bargain!")
            font.pixelSize: player.height/2
        }
        Text{
            anchors.top:bLabel.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: bLabel.horizontalCenter
            text: loops==0?"It's the first time":("You've died "+loops+" time"+(loops>1?"s":"")+" before")
            font.pixelSize: player.height/3
        }

        Timer{
            id:bargainScreenTimer
            interval: 5000
            running: true
            repeat: false
            onTriggered: bargainScreen.visible=false
        }
        Timer{
            id:sfxTimer
            interval: 1000
            running: false
            repeat: false
            onTriggered: ctbSFX.play()
        }

        onVisibleChanged: {
            if(visible){
                bargainScreenTimer.start()
                sfxTimer.start()
            }
            else{
                if(spikeArray.length==0)
                    createSpike()
            }
        }
        Component.onCompleted: ctbSFX.play()
    }
}
