(function() {
  'use strict';

  describe('socialsmartsApp.services', function() {
    var tweets, $httpBackend, pollingService, TrackedTweet,
        xyzTweetData = function() {
          return [{text: "post1", screen_name: "luke", created_at: "2014", klout_score: 20, status: "unresolved"},
                  {text: "post2", screen_name: "kavita", created_at: "2015", klout_score: 30, status: "unresolved"}]
        };

    beforeEach(module('socialsmartsApp.services'));
      beforeEach(inject(function(_$httpBackend_, _pollingService_) {
        $httpBackend = _$httpBackend_;
        pollingService = _pollingService_;
      }));

    describe('Service: pollingService', function() {
      it('returns a JSON object with tweets', inject(function (_$httpBackend_, _pollingService_) {
        $httpBackend.when('GET', '/twitter_timeline.json').respond(xyzTweetData());
        pollingService.startPolling('timeline', '/twitter_timeline.json', 60000, function(resp) {
          tweets = resp.data;
        });
        $httpBackend.flush();
        expect(tweets).toEqual(xyzTweetData());
      }));
    });

    describe('Service: TrackedTweet', function() {
      beforeEach(inject(function(_$httpBackend_, _TrackedTweet_) {
        $httpBackend = _$httpBackend_;
        TrackedTweet = _TrackedTweet_;
      }));

      it('returns a JSON object with tracked tweets', function() {
        $httpBackend.when('GET', '/tracked_tweets.json').respond(xyzTweetData());
        TrackedTweet.query(function(resp) {
          tweets = resp;
        });
        $httpBackend.flush();
        expect(angular.equals(tweets, xyzTweetData())).toEqual(true);
      });

      it("updates a tracked tweet's status", function() {
        $httpBackend.when('PATCH', '/tracked_tweets/1.json').respond({text: "post1", status: "resolved"});
        var tracked_tweet = new TrackedTweet({
          text: "post1", 
          status: "resloved"
        });
        tracked_tweet.$update({id: 1});
        $httpBackend.flush();
        expect(angular.equals(tracked_tweet, {text: "post1", status: "resolved"})).toEqual(true);
      });
    });
  });
})();
