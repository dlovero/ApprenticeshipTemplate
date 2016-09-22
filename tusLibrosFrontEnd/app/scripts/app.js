'use strict';

/**
 * @ngdoc overview
 * @name tusLibrosFrontEndApp
 * @description
 * # tusLibrosFrontEndApp
 *
 * Main module of the application.
 */
angular
    .module('tusLibrosFrontEndApp', [
        'ngAnimate',
        'ngCookies',
        'ngResource',
        'ngRoute',
        'ngSanitize',
        'ngTouch'
    ])
    .config(function ($routeProvider) {
        $routeProvider
            .when('/', {
                templateUrl: 'views/login.html',
                controller: 'LoginController'
            })
            .when('/login', {
                templateUrl: 'views/login.html',
                controller: 'LoginController'
            })
            .when('/main', {
                templateUrl: 'views/main.html',
            })
            .when('/shopping', {
                templateUrl: 'views/shopping.html',
                controller: 'CartController'
            })
            .when('/purchase', {
                templateUrl: 'views/purchase.html',
                controller: 'CreditCardController'
            })
            .when('/all_purchases',{
                templateUrl: 'views/all_purchases.html',
                controller: 'UserController'
            })
            .when('/not_found',{
                templateUrl:'404.html'
            })
            .otherwise({
                redirectTo: '/not_found'
            });
    });
