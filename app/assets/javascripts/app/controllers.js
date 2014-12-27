angular.module('socialsmartsApp.controllers', [])
.controller('DashboardController', function($scope, $http) {
  $http.get('/twitter_timeline.json').success(function(data) {
    $scope.timeline = data;
  });
  $http.get('/twitter_location.json').success(function(data) {
    $scope.locale = data;
    console.log(data)
  });
  $scope.map = { center: { latitude: 45, longitude: -73 }, zoom: 8 };

  // TimelineService.getTimeline()
  // .then(function(data) {
  //   $scope.timeline = data;
  // });
});
