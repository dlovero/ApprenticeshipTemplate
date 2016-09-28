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
        'ngTouch',
        'ngToast'
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
                resolve: {
                    user: function (UserService, $location) {
                        if (UserService.userId === null) {
                            return $location.path('/login');
                        }
                    }
                }
            })
            .when('/shopping', {
                templateUrl: 'views/shopping.html',
                controller: 'CartController',
                resolve: {
                    catalog: function (BookService, $location, ngToast, CartService, UserService) {
                        if (UserService.userId == null) {
                            return $location.path('/login');
                        }
                        return BookService.getCatalog().catch(function (response) {
                            ngToast.danger(response.data.error);
                            return [];
                        })
                    },
                    cart: function (CartService, $location, ngToast, UserService) {
                        if (UserService.userId === null) {
                            return $location.path('/login');
                        }
                        CartService.listCart().catch(function () {
                            ngToast.warning("Vuelva a ingresar para volver a comprar");
                            UserService.logOut();
                            $location.path("/login");
                        });
                        return CartService.currentCart;
                    }
                }
            })
            .when('/purchase', {
                templateUrl: 'views/purchase.html',
                controller: 'CreditCardController',
                resolve: {
                    user: function (UserService, $location) {
                        if (UserService.userId === null) {
                            return $location.path('/login');
                        }
                    }
                }
            })
            .when('/all_purchases', {
                templateUrl: 'views/all_purchases.html',
                controller: 'UserController',
                resolve: {
                    allPurchases: function (UserService, ngToast, $location) {
                        if (UserService.userId === null) {
                            return $location.path('/login');
                        }
                        return UserService.listPurchases().catch(function (response) {
                            ngToast.danger(response.data.error);
                            return [];
                        })
                    }
                }
            })
            .when('/not_found', {
                templateUrl: '404.html'
            })
            .otherwise({
                redirectTo: '/404.html'
            });
    })
    .config(function (ngToastProvider) {
        ngToastProvider.configure({
            verticalPosition: 'top',
            horizontalPosition: 'center'
        });
    })