angular.module('socialsmartsApp.services', ['ngResource'])
.factory('Timeline', function($resource) {
  return $resource('/twitter_timeline/:id.json');
})
.factory('TrackedTweet', function($resource) {
  return $resource('/tracked_tweets/:id.json');
})
.factory('TimelinePoller', function($http, $timeout) {
  var data = {tweets: {}};
  var poller = function() {
    $http.get('/twitter_timeline.json').then(function(resp) {
      data.tweets = resp.data;
      $timeout(poller, 5000);
    });
  };
  poller();
  return {data: data};
});
