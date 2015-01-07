angular.module('socialsmartsApp', ['ngRoute', 'socialsmartsApp.services', 'socialsmartsApp.directives', 'socialsmartsApp.filters', 'socialsmartsApp.controllers', 'uiGmapgoogle-maps', 'ngSanitize'])
.config(function($routeProvider, uiGmapGoogleMapApiProvider) {
  $routeProvider
    .when('/dashboard', {
      templateUrl: '/templates/dashboard.html',
      controller: 'DashboardController'
    })
    .otherwise({
      redirectTo: '/dashboard'
    })
    uiGmapGoogleMapApiProvider.configure({
      key: 'AIzaSyCMPvf6SDEQMMwrlpu1jp9hz_F5XdV4RaE',
      v: '3.17',
      libraries: 'weather,geometry,visualization'
    });
})
.run(function($rootScope){
    $rootScope.$apply($(document).foundation());
});
