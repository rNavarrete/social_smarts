angular.module('socialsmartsApp.controllers', [])
.controller('DashboardController', function($scope, $http, $interval, TrackedTweet, pollingService, $q) {

  sortTrackedTweets();

  pollingService.startPolling('timeline', '/twitter_timeline.json', 300000, function(resp) {
    $scope.timeline = resp.data;
  });

  // pollingService.startPolling('usermentions', '/twitter_usermentions.json', 300000, function(resp) {
  //   $scope.usermentions = resp.data;
  // });

  pollingService.startPolling('current_user_klout', '/currentuser_klout.json', 300000, function(resp) {
    $scope.current_user_klout = resp.data.current_user_klout;
  });

  $scope.orderProp = '-klout_score';

  $scope.options = {styles: [{"featureType":"road","elementType":"labels","stylers":[{"visibility":"simplified"},{"lightness":20}]},{"featureType":"administrative.land_parcel","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"landscape.man_made","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"road.local","elementType":"labels","stylers":[{"visibility":"simplified"}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"visibility":"simplified"}]},{"featureType":"road.highway","elementType":"labels","stylers":[{"visibility":"simplified"}]},{"featureType":"poi","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"road.arterial","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"water","elementType":"all","stylers":[{"hue":"#a1cdfc"},{"saturation":30},{"lightness":49}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"hue":"#f49935"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"hue":"#fad959"}]}]}

  $scope.tweet_message = "";
  var today = new Date();
  var dd = today.getDate();
  var mm = today.getMonth() + 1;
  var yyyy = today.getFullYear();
  $scope.defaultDate = yyyy + "-" + mm + "-" + dd;
  $scope.stweet_time = new Date(1970, 0, 1, 14, 57, 0)
  $scope.stweet_date = today

  $http.get('https://maps.googleapis.com/maps/api/geocode/json?key=' + 'AIzaSyBIjVwl0qhgGMl8PI4AQi6zdn-_SzLCJBE').success(function(data) {
    $scope.map = { center: { latitude: 39.75015, longitude: -104.99987 }, zoom: 16 };
  });

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

    $http.get('/twitter_location.json').success(function(data) {

      var locale = data;

      console.log($scope.usermentions)
        $scope.mentions = []
        for (var i = 0; i < $scope.usermentions.length; i++) {
          if ($scope.usermentions[i].tweet_data.tweet.place) {
            var ret = {idKey: i, latitude: $scope.usermentions[i].tweet_data.tweet.place.bounding_box.coordinates[0][0][1] + Math.random(),
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
      $http.get('https://maps.googleapis.com/maps/api/geocode/json?address=' + locale[0] + '&key=' + 'AIzaSyBIjVwl0qhgGMl8PI4AQi6zdn-_SzLCJBE').success(function(data) {
      $scope.map = { center: { latitude: data.results[0].geometry.location.lat, longitude: data.results[0].geometry.location.lng }, zoom: 8 };
      });
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
