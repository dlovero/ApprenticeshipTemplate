'use strict';

describe('Controller: ListcartcontrollerCtrl', function () {

  // load the controller's module
  beforeEach(module('tusLibrosFrontEndApp'));

  var ListcartcontrollerCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    ListcartcontrollerCtrl = $controller('ListcartcontrollerCtrl', {
      $scope: scope
      // place here mocked dependencies
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(ListcartcontrollerCtrl.awesomeThings.length).toBe(3);
  });
});
