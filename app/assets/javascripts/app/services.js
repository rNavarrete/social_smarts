angular.module('socialsmartsApp.services', ['ngResource'])
.factory('Timeline', function($resource) {
  return $resource('/twitter_timeline/:id.json');
});
