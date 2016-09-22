'use strict';

/**
 * @ngdoc function
 * @name tusLibrosFrontEndApp.controller:UserCtrl
 * @description
 * # UserCtrl
 * Controller of the tusLibrosFrontEndApp
 */
angular.module('tusLibrosFrontEndApp')
    .controller('UserController', function UserController($scope, $location, UserService, CartService) {

        if (CartService.cartId === null) {
           return $location.path('/login');
        }

        $scope.listPurchases = function listPurchases() {
            return UserService.listPurchases().then(function (result) {
                $scope.purchases = result;
            }).catch(function (response) {
                alert(response.data.error);
                $scope.purchases = [];
            });
        };

        $scope.listPurchases();
    });
