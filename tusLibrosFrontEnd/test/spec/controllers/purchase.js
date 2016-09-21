'use strict';

describe('Controller: PurchaseCtrl', function () {

  // load the controller's module
  beforeEach(module('tusLibrosFrontEndApp'));

  var PurchaseCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    PurchaseCtrl = $controller('PurchaseCtrl', {
      $scope: scope
      // place here mocked dependencies
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(PurchaseCtrl.awesomeThings.length).toBe(3);
  });
});
