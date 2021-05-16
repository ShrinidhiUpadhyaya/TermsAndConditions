import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.settings 1.1
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: root

    visible: true
    width: Screen.width
    height: Screen.height
    Material.theme: Material.Dark
    Material.accent: Material.Orange

    property bool contentRead: false
    property bool contentReadNeeded: flickable.contentHeight > flickable.height

    Component.onCompleted: {
        readTextFile("qrc:/Content")
    }

    Settings {
        id: settings

        property bool termsAndConditionsAgreed: false
    }

    header: Rectangle {
        height: 40

        Text {
            text: settings.termsAndConditionsAgreed ? "App" : "Terms And Conditions"
            anchors.centerIn: parent
            font.bold: true
        }
    }

    ColumnLayout {
        width: parent.width - (parent.width * 0.05)
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 5
        visible: !settings.termsAndConditionsAgreed

        Flickable{
            id: flickable

            Layout.fillWidth: true
            Layout.fillHeight: true
            contentHeight: contentTxt.contentHeight
            interactive: true
            boundsBehavior: Flickable.StopAtBounds
            clip: true

            onMovementEnded: {
                if(!root.contentRead)
                    root.contentRead = atYEnd
            }

            ScrollBar.vertical: ScrollBar {
                size: 0.3
                active: true
                orientation: Qt.Vertical
                visible: root.contentReadNeeded
            }

            Text {
                id: contentTxt

                width: contentItem.width - (contentItem.width * 0.04) - 15
                height: parent.height
                wrapMode: Text.WrapAnywhere
                padding: width * 0.01
                color: "white"
            }
        }

        CheckBox {
            id: agreeCheckBox

            Layout.fillWidth: false
            Layout.fillHeight: false
            Layout.preferredWidth: parent.width - (parent.width * 0.1)
            Layout.preferredHeight: parent.height * 0.05
            text: "I accept the Terms and Conditions"
            enabled: root.contentReadNeeded ? root.contentRead : !root.contentReadNeeded
        }

        Button {
            Layout.fillWidth: false
            Layout.fillHeight: false
            Layout.preferredWidth: parent.width - (parent.width * 0.1)
            Layout.preferredHeight: parent.height * 0.06
            Layout.alignment: Qt.AlignHCenter
            text: "Agree"
            Material.background: Material.Teal
            enabled: agreeCheckBox.checked

            onClicked: {
                settings.termsAndConditionsAgreed = true;
            }
        }
    }

    Text {
        text: "Welcome To The App";
        visible: settings.termsAndConditionsAgreed
        anchors.centerIn: parent
        color: "white"
    }

    function readTextFile(filePath){
        var xhr = new XMLHttpRequest;
        xhr.open("GET", filePath);
        xhr.onreadystatechange = function () {
            if(xhr.readyState === XMLHttpRequest.DONE){
                var response = xhr.responseText;
                contentTxt.text = response;
            }
        }
        xhr.send();
    }
}
