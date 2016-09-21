'use strict';

/**
 * @ngdoc function
 * @name tusLibrosFrontEndApp.controller:LoginCtrl
 * @description
 * # LoginCtrl
 * Controller of the tusLibrosFrontEndApp
 */
angular.module('tusLibrosFrontEndApp')
    .controller('LoginController', ['$scope', '$location', 'CartService', function LoginController($scope, $location, CartService) {
        $scope.userId = 1;
        $scope.password = "123456";

        $scope.login = function login(userId, password) {
            CartService.submit(userId, password).then(function (response) {
                return $location.path('/main');
            }).catch(function () {
                $scope.userId = null;
                $scope.password = '';
            });
        }

    }]);


