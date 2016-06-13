/*global cordova, module*/

module.exports = {
    getStatus: function (successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "AppleMusic", "getStatus");
    },
    playTrack: function (trackId, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "AppleMusic", "playTrack", [trackId]);
    },
    requestAuthorization: function (successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "AppleMusic", "requestAuthorization");
    },
    getStorefrontID: function (successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "AppleMusic", "getStorefrontID");
    }
};