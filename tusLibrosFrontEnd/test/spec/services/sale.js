'use strict';

describe('Service: Sale', function () {

  // load the service's module
  beforeEach(module('tusLibrosFrontEndApp'));

  // instantiate service
  var Sale;
  beforeEach(inject(function (_Sale_) {
    Sale = _Sale_;
  }));

  it('should do something', function () {
    expect(!!Sale).toBe(true);
  });

});
