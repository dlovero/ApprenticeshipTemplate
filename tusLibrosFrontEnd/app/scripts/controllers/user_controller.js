'use strict';

/**
 * @ngdoc function
 * @name tusLibrosFrontEndApp.controller:UserCtrl
 * @description
 * # UserCtrl
 * Controller of the tusLibrosFrontEndApp
 */
angular.module('tusLibrosFrontEndApp')
    .controller('UserController', function UserController($scope, $location, allPurchases, CartService, UserService) {



        $scope.listPurchases = function listPurchases() {
            return UserService.listPurchases().then(function (result) {
                $scope.items = result;
            }).catch(function (response) {
                alert(response.data.error);
                $scope.items = [];
            });
        };

        $scope.items=allPurchases;
    });
