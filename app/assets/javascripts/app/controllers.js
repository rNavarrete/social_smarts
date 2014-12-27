angular.module('socialsmartsApp.controllers', [])
.controller('DashboardController', function($scope, $http) {
  $http.get('/twitter_timeline.json').success(function(data) {
    console.log(data)
    $scope.timeline = data;
  });
  
  // TimelineService.getTimeline()
  // .then(function(data) {
  //   $scope.timeline = data;
  // });
});
