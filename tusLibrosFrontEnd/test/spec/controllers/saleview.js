'use strict';

describe('Controller: SaleviewCtrl', function () {

  // load the controller's module
  beforeEach(module('tusLibrosFrontEndApp'));

  var SaleviewCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    SaleviewCtrl = $controller('SaleviewCtrl', {
      $scope: scope
      // place here mocked dependencies
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(SaleviewCtrl.awesomeThings.length).toBe(3);
  });
});
