(function() {
  "use strict";

  describe("Controller: DashboardController", function() {
    var scope, fakeTrackedTweets;

    beforeEach(module('socialsmartsApp', function($provide) {
      fakeTrackedTweets = [{text: "post1", status: "unresolved", screen_name: "luke", created_at: "2014", klout_score: 20},
                           {text: "post2", status: "unresolved", screen_name: "kavita", created_at: "2015", klout_score: 30}];
    
      var fakeTrackedTweetService = {
        query: function() {
          return fakeTrackedTweets;
        }
      };

      $provide.value("TrackedTweet", fakeTrackedTweetService);
    }));

    beforeEach(inject(function ($controller, $rootScope) {
      scope = $rootScope.$new();
      $controller('DashboardController', { $scope: scope });
    }));

    it('populates the scope with the tracked tweets array', function () {
      expect(scope.unresolved).toEqual(fakeTrackedTweets);
    });
  });
})();
