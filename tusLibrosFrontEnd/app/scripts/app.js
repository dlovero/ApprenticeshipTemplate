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
                templateUrl: 'views/createCart.html',
                controller: 'LoginController'
            })
            .when('/login', {
                templateUrl: 'views/login.html',
                controller: 'LoginController'
            })
            .when('/main', {
                templateUrl: 'views/main.html',
                controller: 'MainController'
            })
            .when('/shopping', {
                templateUrl: 'views/shopping.html',
                controller: 'CartController',
                resolve: {
                    catalog: function (BookService) {
                        return BookService.getCatalog().catch(function (response) {
                            alert(response.data.error);
                            $scope.catalog = [];
                        })
                    },
                    cart: function (CartService) {
                        return CartService.currentCart;
                    }
                }
            })
            .when('/purchase', {
                templateUrl: 'views/purchase.html',
                controller: 'CreditCardController'
            })
            .when('/all_purchases', {
                templateUrl: 'views/all_purchases.html',
                controller: 'UserController',
                resolve: {
                    allPurchases: function (UserService) {
                        return UserService.listPurchases().catch(function (response) {
                            alert(response.data.error);
                            $scope.purchases = [];
                        })
                    }
                }
            })
            .when('/not_found', {
                templateUrl: '404.html'
            })
            .otherwise({
                redirectTo: '/login'
            });
    });
