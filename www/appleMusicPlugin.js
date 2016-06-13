/*global cordova, module*/

module.exports = {
    getStatus: function (successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "AppleMusic", "getStatus");
    },
    playTrack: function (trackId, successCallback, errorCallback) {
        cordova.exec(trackId, successCallback, errorCallback, "AppleMusic", "playTrack");
    },
    requestAuthorization: function (successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "AppleMusic", "requestAuthorization");
    }
};