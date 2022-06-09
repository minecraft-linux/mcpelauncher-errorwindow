import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Dialogs

Window {
    id: window
    visible: true
    width: 320
    height: 240
    title: TITLE
        TextEdit {
            textFormat: TextEdit.RichText
            text: DESCRIPTION
            readOnly: true
            anchors.fill: parent
            wrapMode: Text.WordWrap
            selectByMouse: true
        }

}