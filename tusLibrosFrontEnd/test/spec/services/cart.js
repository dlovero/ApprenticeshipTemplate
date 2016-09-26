'use strict';

describe('Service: CartProvider', function () {

  // load the service's module
  beforeEach(module('tusLibrosFrontEndApp'));

  // instantiate service
  var Cart;
  beforeEach(inject(function (_Cart_) {
    Cart = _Cart_;
  }));

  it('should do something', function () {
    expect(!!Cart).toBe(true);
  });

});
