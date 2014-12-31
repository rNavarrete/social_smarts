(function() {
  'use strict';

  describe('Service: pollingService', function() {
    beforeEach(module('socialsmartsApp.services'));

    it('returns a JSON object with tweets', inject(function ($httpBackend, pollingService) {
      var tweets;

      $httpBackend.when('GET', '/twitter_timeline.json').respond([{text: "post1", screen_name: "luke", created_at: "2014"},
                                                                  {text: "post2", screen_name: "kavita", created_at: "2015"}]);

      pollingService.startPolling('timeline', '/twitter_timeline.json', 60000, function(resp) {
        tweets = resp.data;
      });

      $httpBackend.flush();
      expect(tweets).toEqual([{text: "post1", screen_name: "luke", created_at: "2014"},
                              {text: "post2", screen_name: "kavita", created_at: "2015"}]);
    }));
  });
})();
