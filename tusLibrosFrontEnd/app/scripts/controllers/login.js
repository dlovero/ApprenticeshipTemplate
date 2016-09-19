'use strict';

/**
 * @ngdoc function
 * @name tusLibrosFrontEndApp.controller:LoginCtrl
 * @description
 * # LoginCtrl
 * Controller of the tusLibrosFrontEndApp
 */
angular.module('tusLibrosFrontEndApp')
  .controller('LoginController', function ($scope) {
      $scope.username = "";
      $scope.password = "";

      $scope.login=function login(){
          if("ludat" === $scope.username && "123456"=== $scope.password){
              alert("Si");
          } else {
              alert("No");
          }
      }

  });
