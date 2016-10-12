'use strict';

/**
 * @ngdoc overview
 * @name ticTacToeFrontEndApp
 * @description
 * # ticTacToeFrontEndApp
 *
 * Main module of the application.
 */
angular
    .module('ticTacToeFrontEndApp', [
        'ngAnimate',
        'ngCookies',
        'ngResource',
        'ngRoute',
        'ngSanitize',
        'ngTouch',
        'ngToast'
    ])
    .config(function ($routeProvider) {
        $routeProvider
            .when('/game', {
                templateUrl: 'views/game.html',
                controller: 'GameController',
                resolve: {
                    board: function (BoardService) {
                        return BoardService.new();
                    }
                }
            })
            .when('/login', {
                templateUrl: 'views/login.html',
                controller: 'UserController'
            })
            .when('/register', {
                templateUrl: 'views/register.html',
                controller: 'UserController'
            })
            .when('/welcome', {
                templateUrl: 'views/welcome.html'
            })
            .otherwise({
                redirectTo: '/login'
            });
    })
    .config(function (ngToastProvider) {
        ngToastProvider.configure({
            verticalPosition: 'top',
            horizontalPosition: 'center'
        });
    });
