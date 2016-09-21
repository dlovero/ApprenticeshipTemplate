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
                controller: 'LoginController',
                controllerAs: 'login'
            })
            .when('/main', {
                templateUrl: 'views/main.html',
                controller: 'MainController',
                controllerAs: 'main'
            })
            .when('/continueBuying', {
                templateUrl: 'views/continue.html',
                controller: 'CartController',
                controllerAs: 'cart'
            })
            .when('/showCatalog', {
                templateUrl: 'views/catalog.html',
                controller: 'CatalogController',
                controllerAs: 'catalog'
            })
            .when('/showPurchases',{
                templateUrl: 'views/all_purchases.html',
                controller: 'UserController',
                controllerAs: 'user'
            })
            .when('/showCart', {
                templateUrl: 'views/list_cart.html',
                controller: 'ListCartController',
                controllerAs: 'cart'
            })
            .when('/purchase', {
                templateUrl: 'views/purchase.html',
                controller: 'CartController',
                controllerAs: 'cart'
            })
            .otherwise({
                redirectTo: '/'
            });
    });
