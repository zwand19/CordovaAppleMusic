/*global cordova, module*/

module.exports = {
    getStatus: function (successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "AppleMusic", "getStatus");
    }
    requestAuthorization: function (successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "AppleMusic", "requestAuthorization");
    }
};