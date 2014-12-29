angular.module('socialsmartsApp.services', ['ngResource'])
.factory('Timeline', function($resource) {
  return $resource('/twitter_timeline/:id.json');
})
.factory('TrackedTweet', function($resource) {
  return $resource('/tracked_tweets/:id.json');
});
