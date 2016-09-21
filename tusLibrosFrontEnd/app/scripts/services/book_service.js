'use strict';

/**
 * @ngdoc service
 * @name tusLibrosFrontEndApp.authentication
 * @description
 * # authentication
 * Service in the tusLibrosFrontEndApp.
 */
angular.module('tusLibrosFrontEndApp')
  .service('BookService', function BookService($http) {
      var self = this;
      self.catalog = [];
      self.getCatalog = function getCatalog(){
         return $http.get('http://localhost:3000/listCatalog').then(function(response){
             return response.data;
         });
      }
  });
