angular.module('socialsmartsApp', ['socialsmartsApp.controllers'])
.config(function($routeProvider) {
  $routeProvider
    .when('/dashboard', {
      templateUrl: '/templates/dashboard.html', 
      controller: 'HomeController',
      resolve: {
        session: function(SessionService) {
          return SessionService.getCurrentUser();
        }
      }
    })
    .otherwise({
      redirectTo: '/dashboard'
  })
})
.run(function($rootScope){
    $rootScope.$apply($(document).foundation());
});
