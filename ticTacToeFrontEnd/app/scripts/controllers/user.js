'use strict';

/**
 * @ngdoc function
 * @name ticTacToeFrontEndApp.controller:UsercontrollerCtrl
 * @description
 * # UserController
 * Controller of the ticTacToeFrontEndApp
 */
angular.module('ticTacToeFrontEndApp')
    .controller('UserController', function ($scope,UserService,$location) {
        $scope.username = '';

        $scope.login = function login(){
            UserService.login($scope.username).then(function(){
                $location.path("/welcome");
            })
        };

        $scope.register = function register(){
            UserService.register($scope.username).then(function(){
                $location.path("/welcome");
            })
        };

    });
