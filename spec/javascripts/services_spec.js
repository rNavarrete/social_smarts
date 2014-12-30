(function() {
  'use strict';

  describe('Service: TimelinePoller', function() {
    beforeEach(module('socialsmartsApp.services'));

    it('returns a JSON object with todo items', inject(function ($httpBackend, TimelinePoller) {
      var items;
      $httpBackend.when('GET', '/twitter_timeline.json').respond([{text: "post1", screen_name: "luke", created_at: "2014"},
                                                                  {text: "post2", screen_name: "kavita", created_at: "2015"}]);
    });
  });
})();
