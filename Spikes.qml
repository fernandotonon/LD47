import QtQuick 2.15
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

Item {
    width: targetObj.width/10+1
    height: targetObj.height/2+2
    property alias tracking: target.visible
    property var targetObj
    signal touch()

    onTargetObjChanged:{
        targetObj.onXChanged.connect(verifyCollision)
        targetObj.onYChanged.connect(verifyCollision)
    }

    NumberAnimation on x {
        from: x
        to: targetObj.x+targetObj.width/2
        duration: 200
        running: tracking
        easing.type: Easing.InQuad
    }
    NumberAnimation on y {
        from: y
        to: targetObj.y+targetObj.height-height
        duration: 200
        running: tracking
        easing.type: Easing.InQuad
    }

    Item{
        id:spikes
        anchors.fill: parent
        visible: !target.visible
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
            verifyCollision()
            if(visible){
                spikeSFX.play()
            }
        }
    }

    SoundEffect{
        id:spikeSFX
        source: "/SFX/spike.wav"
    }

    function verifyCollision(){
        if(spikes!==undefined && spikes.visible && targetObj!==undefined)
            if(spikes.parent.x<targetObj.x+targetObj.width&&
               spikes.parent.x+spikes.width>targetObj.x&&
               spikes.parent.y<targetObj.y+targetObj.height&&
               spikes.parent.y+spikes.height>targetObj.y)
                touch()
    }

    Image{
        id:target
        x:-width/2
        width: parent.height
        height: parent.height
        source:"/images/target.png"
        Timer{
            interval: 1000+Math.random()*1000
            repeat: true
            running: true
            onTriggered: {
                parent.visible=!parent.visible
            }
        }
    }
    ColorOverlay {
            anchors.fill: target
            source: target
            color: "#FFFFFF00"
            visible: target.visible
        }

}
