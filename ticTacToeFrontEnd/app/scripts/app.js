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
            .when('/', {
                templateUrl: 'views/main.html',
                controller: 'MainCtrl',
                resolve: {
                    board: function (BoardService) {
                        return BoardService.new();
                    }
                }
            })
            .otherwise({
                redirectTo: '/'
            });
    })
    .config(function (ngToastProvider) {
        ngToastProvider.configure({
            verticalPosition: 'top',
            horizontalPosition: 'center'
        });
    });
