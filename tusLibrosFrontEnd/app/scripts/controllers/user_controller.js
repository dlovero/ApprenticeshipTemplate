'use strict';

/**
 * @ngdoc function
 * @name tusLibrosFrontEndApp.controller:UserCtrl
 * @description
 * # UserCtrl
 * Controller of the tusLibrosFrontEndApp
 */
angular.module('tusLibrosFrontEndApp')
    .controller('UserController', function UserController($scope, $location, SalesService, CartService) {

        if (CartService.currentCart === null) {
           return $location.path('/login');
        }

        $scope.listPurchases = function listPurchases() {
            return SalesService.listPurchases().then(function (result) {
                $scope.purchases = result;
            }).catch(function (response) {
                alert(response.data.error);
                $scope.purchases = [];
            });
        };

        $scope.listPurchases();
    });
