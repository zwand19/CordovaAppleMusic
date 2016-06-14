/*global cordova, module*/

module.exports = {
    getStatus: function (successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "AppleMusic", "getStatus");
    },
    init: function (successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "AppleMusic", "init");
    },
    onStopPlaying: function(f) {
      window.appleMusicPluginStoppedPlaying = f
    },
    playTrack: function (trackId, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "AppleMusic", "playTrack", [trackId]);
    },
    requestAuthorization: function (successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "AppleMusic", "requestAuthorization");
    }
};