angular.module('socialsmartsApp.controllers', [])
.controller('DashboardController', function($scope, $http, Timeline, TrackedTweet, TimelinePoller) {
  $scope.tracked = TrackedTweet.query();

  $scope.track = function(tweet) {
    var tracked_tweet = new TrackedTweet({
      text: tweet.text,
      screen_name: tweet.screen_name,
      created_at: tweet.created_at
    });
    tracked_tweet.$save(function() {
      $scope.tracked = TrackedTweet.query();
    });
  };

  $scope.untrack = function(tweet) {
    var tracked_tweet = new TrackedTweet;
    tracked_tweet.$delete({id: tweet.id}, function() {
      $scope.tracked = TrackedTweet.query();
    });
  }

  $scope.$on('timeline-poll', function() {
    $scope.timeline = TimelinePoller.data.tweets;
  });

  $http.get('/twitter_location.json').success(function(data) {
    var locale = data;


  $http.get('https://maps.googleapis.com/maps/api/geocode/json?address=' + locale[0] + '&key=AIzaSyCMPvf6SDEQMMwrlpu1jp9hz_F5XdV4RaE').success(function(data) {
    $scope.map = { center: { latitude: data.results[0].geometry.location.lat, longitude: data.results[0].geometry.location.lng }, zoom: 8 };
      console.log(locale[0])
    });
  });
});
