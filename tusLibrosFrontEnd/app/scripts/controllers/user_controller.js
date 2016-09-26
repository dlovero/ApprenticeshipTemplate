'use strict';

/**
 * @ngdoc function
 * @name tusLibrosFrontEndApp.controller:UserCtrl
 * @description
 * # UserCtrl
 * Controller of the tusLibrosFrontEndApp
 */
angular.module('tusLibrosFrontEndApp')
    .controller('UserController', function UserController($scope, $location, CartService, UserService) {

        if (CartService.currentCart === null) {
           return $location.path('/createCart');
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
