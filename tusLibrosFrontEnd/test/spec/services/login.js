'use strict';

describe('Service: createCart', function () {

  // load the service's module
  beforeEach(module('tusLibrosFrontEndApp'));

  // instantiate service
  var login;
  beforeEach(inject(function (_login_) {
    login = _login_;
  }));

  it('should do something', function () {
    expect(!!login).toBe(true);
  });

});
