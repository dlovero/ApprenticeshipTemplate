'use strict';

/**
 * @ngdoc function
 * @name tusLibrosFrontEndApp.controller:ListcartcontrollerCtrl
 * @description
 * # ListcartcontrollerCtrl
 * Controller of the tusLibrosFrontEndApp
 */
angular.module('tusLibrosFrontEndApp')
    .controller('ListCartController', function ListCart($scope, CartService) {
        CartService.list_cart().then(function list_response(list_of_items){
            $scope.items = list_of_items;
        }).on_error = $scope.items = []
    });
