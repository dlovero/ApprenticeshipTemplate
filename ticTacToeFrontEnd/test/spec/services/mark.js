'use strict';

describe('Service: Mark', function () {

  // load the service's module
  beforeEach(module('ticTacToeFrontEndApp'));

  // instantiate service
  var Mark;
  beforeEach(inject(function (_Mark_) {
    Mark = _Mark_;
  }));

  it('should do something', function () {
    expect(!!Mark).toBe(true);
  });

});
