'use strict';

/**
 * @ngdoc function
 * @name tusLibrosFrontEndApp.controller:LoginCtrl
 * @description
 * # LoginCtrl
 * Controller of the tusLibrosFrontEndApp
 */
angular.module('tusLibrosFrontEndApp')
    .controller('LoginController', function LoginController($scope, $location, CartService) {
        $scope.userId = 1;
        $scope.password = "123456";

        $scope.login = function login() {
            CartService.submit($scope.userId, $scope.password).then(function (response) {
                return $location.path('/main');
            }).catch(function () {
                $scope.userId = null;
                $scope.password = '';
            });
        };

    });


