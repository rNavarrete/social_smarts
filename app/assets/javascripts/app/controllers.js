angular.module('socialsmartsApp.controllers', [])
.controller('DashboardController', function($scope, $http, $interval, TrackedTweet, pollingService) {

  sortTrackedTweets();

  var fiveMin = 300000;

  pollingService.startPolling('timeline', '/twitter_timeline.json', fiveMin, function(resp) {
    $scope.timeline = resp.data;
  });

  pollingService.startPolling('followers', '/twitter_followers.json', fiveMin, function(resp) {
    $scope.followers = resp.data;
  });

  pollingService.startPolling('current_user_klout', '/currentuser_klout.json', fiveMin, function(resp) {
    $scope.current_user_klout = resp.data.current_user_klout;
  });



  $scope.orderProp = '-klout_score';
  $scope.options = {styles: [{"featureType":"landscape","stylers":[{"saturation":-100},{"lightness":65},{"visibility":"on"}]},{"featureType":"poi","stylers":[{"saturation":-100},{"lightness":51},{"visibility":"simplified"}]},{"featureType":"road.highway","stylers":[{"saturation":-100},{"visibility":"simplified"}]},{"featureType":"road.arterial","stylers":[{"saturation":-100},{"lightness":30},{"visibility":"on"}]},{"featureType":"road.local","stylers":[{"saturation":-100},{"lightness":40},{"visibility":"on"}]},{"featureType":"transit","stylers":[{"saturation":-100},{"visibility":"simplified"}]},{"featureType":"administrative.province","stylers":[{"visibility":"off"}]},{"featureType":"water","elementType":"labels","stylers":[{"visibility":"on"},{"lightness":-25},{"saturation":-100}]},{"featureType":"water","elementType":"geometry","stylers":[{"hue":"#ffff00"},{"lightness":-25},{"saturation":-97}]}]}


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

  $scope.track = function(tweet) {
    var tracked_tweet = new TrackedTweet({
      text: tweet.text,
      screen_name: tweet.screen_name,
      klout_score: tweet.klout_score,
      status: "unresolved",
      created_at: tweet.created_at
    });
    tracked_tweet.$save(function() {
      sortTrackedTweets();
    });
  };

  $scope.untrack = function(tweet) {
    var resolved_track = new TrackedTweet({
      status: "resolved"
    });
    resolved_track.$update({id: tweet.id}, function() {
      sortTrackedTweets();
    });
  };

  $scope.retrack = function(tweet) {
    var unresolved_track = new TrackedTweet({
      status: "unresolved"
    });
    unresolved_track.$update({id: tweet.id}, function() {
      sortTrackedTweets();
    });
  };

  $scope.deleteTrack = function(tweet) {
    var tracked_tweet = new TrackedTweet;
    tracked_tweet.$delete({id: tweet.id}, function() {
      sortTrackedTweets();
    })
  }

  pollingService.startPolling('usermentions', '/twitter_usermentions.json', 60000, function(resp) {
    $scope.usermentions = resp.data;



      console.log($scope.usermentions)
        $scope.mentions = []
        for (var i = 0; i < $scope.usermentions.length; i++) {
          if ($scope.usermentions[i].tweet_data.tweet.place) {
            var ret = {idKey: i, latitude: $scope.usermentions[i].tweet_data.tweet.place.bounding_box.coordinates[0][0][1] + (Math.random() * (0.01 - 0.05) + 0.01),
              longitude: $scope.usermentions[i].tweet_data.tweet.place.bounding_box.coordinates[0][0][0], title: $scope.usermentions[i].text, show: false, author: $scope.usermentions[i].screen_name}

              ret.onClick = function() {
                ret.show = !ret.show;
              };

              $scope.mentions.push(ret);
            } else if ($scope.usermentions[i].latitude_from_profile){
            var ret = {idKey: i, latitude: $scope.usermentions[i].latitude_from_profile,
              longitude: $scope.usermentions[i].longitude_from_profile, title: $scope.usermentions[i].text, show: false, author: $scope.usermentions[i].screen_name}

              ret.onClick = function() {
                ret.show = !ret.show;
              };

              $scope.mentions.push(ret);
            }  else {
            };
        };
      });

  $http.get('/twitter_location.json').success(function(data) {
    var locale = data;

    $http.get('https://maps.googleapis.com/maps/api/geocode/json?address=' + locale[0] + '&key=' + 'AIzaSyCkCtk5jlm5ZiT47hqEsqVlQ5u97k7my4A').success(function(data) {
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

  function sortTrackedTweets() {
    TrackedTweet.query(function(resp) {
      var tracked_tweets = resp
      $scope.unresolved = tracked_tweets.filter(function(v) {
        return v.status === "unresolved";
      });
      $scope.resolved = tracked_tweets.filter(function(v) {
        return v.status === "resolved";
      });
    });
  }

});
