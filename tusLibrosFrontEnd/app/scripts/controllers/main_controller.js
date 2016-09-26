'use strict';

/**
 * @ngdoc function
 * @name tusLibrosFrontEndApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the tusLibrosFrontEndApp
 */
angular.module('tusLibrosFrontEndApp')
  .controller('MainController', function MainController($location,CartService){

      if (CartService.currentCart === null) {
         return $location.path('/login');
      }

  });
