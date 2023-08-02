/* This file is generated and only relevant for integrating the project into a Qt 6 and cmake based
C++ project. */

import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

// Importing custom QML components
import "qml/components"
import "qml/components/shared"

ApplicationWindow {
    id : mainWindow;
    visible: true;
    width : 1920;
    height: 1080;
    title: qsTr("Jenoptik")
    color : "#EBF1F4"

    EventBus {
        id: eventBus
        onShowMessage: function(message, type) {// Function to execute when the showMessage signal is emitted
            console.log(message + ": " + type);
            // Use the NotificationBanner's showMessage function to display the message
            notificationBanner.showMessage(message,type);
        }
    }

    NavBar{
        id: navbarSection
        eventBus: eventBus  // Connect NavBar to the EventBus
    }

    ToolBarComponent{
        id: toolbarSection
    }

    SideBarComponent{
        id : sideBarSection
        eventBus:  eventBus // Connect SideBarComponent to the EventBus
    }

    NotificationBanner {
        id: notificationBanner
        anchors.horizontalCenter: parent.horizontalCenter
        parentHeight : mainWindow.height
    }

    Component.onCompleted: {
        // Connects the showMessage signal of the EventBus to the showMessage method of the NotificationBanner
        eventBus.showMessage.connect(notificationBanner.showMessage);
    }




}
