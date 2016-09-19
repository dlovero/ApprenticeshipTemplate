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
      .otherwise({
        redirectTo: '/'
      });
  });
