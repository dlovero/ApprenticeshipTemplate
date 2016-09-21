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
        $scope.user_id = 1;
        $scope.password = "123456";
        $scope.cart_id = null;

        $scope.login = function login(user_id, password) {
            CartService.submit(user_id, password).then(function () {
                return $location.path('/main');
            }).catch(function () {
                $scope.user_id = null;
                $scope.cart_id = null;
                $scope.password = '';
            });
        }

    }]);


