"use strict";

describe('socialsmartsApp', function() {
  it('should get the dashboard', function() {
    browser.get('/dashboard');
    browser.getLocationAbsUrl().then(function(url) {
      expect(url).toBe('/#/dashboard');
    });
  });
});
