'use strict';

describe('Service: BackendUrls', function () {

  // load the service's module
  beforeEach(module('tusLibrosFrontEndApp'));

  // instantiate service
  var BackendUrls;
  beforeEach(inject(function (_BackendUrls_) {
    BackendUrls = _BackendUrls_;
  }));

  it('should do something', function () {
    expect(!!BackendUrls).toBe(true);
  });

});
