'use strict';

/**
 * @ngdoc function
 * @name tusLibrosFrontEndApp.controller:LoginCtrl
 * @description
 * # LoginCtrl
 * Controller of the tusLibrosFrontEndApp
 */
angular.module('tusLibrosFrontEndApp')
    .controller('LoginController', function LoginController($scope, $location, UserService, CartService) {

        $scope.userId = 1;
        $scope.password = "123456";

        $scope.UserService = UserService;

        $scope.login = function login() {
            CartService.createCart($scope.userId, $scope.password).then(function () {
                UserService.set_user_and_password($scope.userId, $scope.password);
                $location.path('/main');
            })
        };
    });


