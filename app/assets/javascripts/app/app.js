angular.module('socialsmartsApp', ['ngRoute', 'socialsmartsApp.services', 'socialsmartsApp.directives', 'socialsmartsApp.filters', 'socialsmartsApp.controllers'])
.config(function($routeProvider) {
  $routeProvider
    .when('/dashboard', {
      templateUrl: '/templates/dashboard.html', 
      controller: 'DashboardController',
    })
    .otherwise({
      redirectTo: '/dashboard'
  })
})
.run(function($rootScope){
    $rootScope.$apply($(document).foundation());
});
