'use strict';

describe('Service: LoginCheck', function () {

  // load the service's module
  beforeEach(module('tusLibrosFrontEndApp'));

  // instantiate service
  var LoginCheck;
  beforeEach(inject(function (_LoginCheck_) {
    LoginCheck = _LoginCheck_;
  }));

  it('should do something', function () {
    expect(!!LoginCheck).toBe(true);
  });

});
