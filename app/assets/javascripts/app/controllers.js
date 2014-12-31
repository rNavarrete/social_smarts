angular.module('socialsmartsApp.controllers', [])
.controller('DashboardController', function($scope, $http, $interval, TrackedTweet, pollingService) {
  pollingService.startPolling('timeline', '/twitter_timeline.json', 60000, function(resp) {
    $scope.timeline = resp.data;
  });

  pollingService.startPolling('usermentions', '/twitter_usermentions.json', 60000, function(resp) {
    $scope.usermentions = resp.data;
  });

  $scope.tracked = TrackedTweet.query();

  $scope.orderProp = '-klout_score';

  $scope.tweet_message = "";
  var today = new Date();
  var dd = today.getDate();
  var mm = today.getMonth() + 1;
  var yyyy = today.getFullYear();
  $scope.defaultDate = yyyy + "-" + mm + "-" + dd;
  $scope.stweet_time = new Date(1970, 0, 1, 14, 57, 0)
  $scope.stweet_date = today

  $scope.disabled = function(tweet_message) {
    if (tweet_message == null || tweet_message.length > 140 || tweet_message.length < 1) {
      return true;
    }
  };

  $scope.length = function(tweet_message) {
    if (tweet_message == null){
      return 0
    } else {
      return tweet_message.length
    }
  }

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

  $http.get('/twitter_location.json').success(function(data) {
    var locale = data;
    $http.get('/twitter_mentions.json').success(function(atmentions) {
      $scope.mentions = []
      for (var i = 0; i < atmentions.length; i++) {
        if (atmentions[i].tweet.place) {
          var ret = {idKey: i, latitude: atmentions[i].tweet.place.bounding_box.coordinates[0][0][1],
            longitude: atmentions[i].tweet.place.bounding_box.coordinates[0][0][0], title: atmentions[i].tweet.text, show: false, author: atmentions[i].tweet.user.screen_name
          };

          ret.onClick = function() {
            console.log("Clicked!");
            ret.show = !ret.show;
          };

          $scope.mentions.push(ret);
        }
      }
    });
    $http.get('https://maps.googleapis.com/maps/api/geocode/json?address=' + locale[0] + '&key=' + 'AIzaSyCMPvf6SDEQMMwrlpu1jp9hz_F5XdV4RaE').success(function(data) {
    $scope.map = { center: { latitude: data.results[0].geometry.location.lat, longitude: data.results[0].geometry.location.lng }, zoom: 8 };
    });
  });

  $scope.sendTweet = function(tweet_message) {
    $http.post('/twitter_timeline.json', {tweet: tweet_message})
    .success(function(data, status, headers, config) {
      if (data.status === 'ok') {
        $scope.tweet_message = null;

        $scope.messages = 'Your form has been sent!';
        // $scope.submitted = false;
      } else {
        $scope.messages = 'Oops, we received your request, but there was an error processing it.';
        // $log.error(data);
      }
    })
    .error(function(data, status, headers, config) {
      $scope.tweet_message = null;
      $scope.messages = 'There was a network error. Try again later.';
    })
    .finally(function() {
      // Hide status messages after three seconds.
      $interval(function() {
        $scope.messages = null;
      }, [3000]);
    });
  }

  $scope.sendStweet = function(tweet_message, tweet_time, tweet_date) {
    $http.post('/scheduled_tweet.json', {tweet: tweet_message, time: tweet_time, date: tweet_date})
    .success(function(data, status, headers, config) {
      if (data.status === 'ok') {
        $scope.stweet_message = null;

        $scope.messages = 'Your form has been sent!';
        // $scope.submitted = false;
      } else {
        $scope.messages = 'Oops, we received your request, but there was an error processing it.';
        // $log.error(data);
      }
    })
    .error(function(data, status, headers, config) {
      $scope.tweet_message = null;
      $scope.messages = 'There was a network error. Try again later.';
    })
    .finally(function() {
      // Hide status messages after three seconds.
      $interval(function() {
        $scope.messages = null;
      }, [3000]);
    });
  }

});
