'use strict';

describe('Directive: CustomTable', function () {

  // load the directive's module
  beforeEach(module('tusLibrosFrontEndApp'));

  var element,
    scope;

  beforeEach(inject(function ($rootScope) {
    scope = $rootScope.$new();
  }));

  it('should make hidden element visible', inject(function ($compile) {
    element = angular.element('<-custom-table></-custom-table>');
    element = $compile(element)(scope);
    expect(element.text()).toBe('this is the CustomTable directive');
  }));
});
