import QtQuick 2.0

// This QtObject defines an EventBus to facilitate communication within the application.
// It is useful when different components need to communicate without
// having to be directly connected. (in our case the dialogs and the main)
QtObject {

    // Signal that can be emitted with a message and a type.
    // Other parts of the application can connect to this signal to be notified when a message should be shown.
    signal showMessage(string message, string type)

    function sendSuccessMessage(message) {
        showMessage(message, "success");
    }

    function sendErrorMessage(message) {
        showMessage(message, "error");
    }
}
