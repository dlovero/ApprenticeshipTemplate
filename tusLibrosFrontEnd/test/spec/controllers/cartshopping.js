'use strict';

describe('Controller: CartshoppingCtrl', function () {

  // load the controller's module
  beforeEach(module('tusLibrosFrontEndApp'));

  var CartshoppingCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    CartshoppingCtrl = $controller('CartshoppingCtrl', {
      $scope: scope
      // place here mocked dependencies
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(CartshoppingCtrl.awesomeThings.length).toBe(3);
  });
});
