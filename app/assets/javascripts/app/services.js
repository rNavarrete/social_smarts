angular.module('socialsmartsApp.services', ['ngResource'])
.factory('TimelineService', function($http) {
  var service;
  return service = {
    getTimeline: function() {
      $http.get('/twitter_timeline').success(function(data) {
        return data;
      });
    }
  };
});
