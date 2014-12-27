angular.module('socialsmartsApp.controllers', [])
.controller('DashboardController', function($scope, $http) {
  $http.get('/twitter_timeline.json').success(function(data) {
    $scope.timeline = data;
  });
  $http.get('/twitter_location.json').success(function(data) {
    var locale = data;
  $http.get('https://maps.googleapis.com/maps/api/geocode/json?address=' + locale[0] + '&key=' + 'AIzaSyCMPvf6SDEQMMwrlpu1jp9hz_F5XdV4RaE').success(function(data) {
  $scope.map = { center: { latitude: data.results[0].geometry.location.lat, longitude: data.results[0].geometry.location.lng }, zoom: 8 };
    console.log(locale[0])
  });
});
  // TimelineService.getTimeline()
  // .then(function(data) {
  //   $scope.timeline = data;
  // });
});
