'use strict';

/**
 * @ngdoc service
 * @name tusLibrosFrontEndApp.authentication
 * @description
 * # authentication
 * Service in the tusLibrosFrontEndApp.
 */
angular.module('tusLibrosFrontEndApp')
  .service('BookService', function BookService($http,BACKEND_URL) {
      var self = this;
      self.catalog = [];
      self.getCatalog = function getCatalog(){
         return $http.get(BACKEND_URL+'books').then(function(response){
             return response.data;
         });
      }
  });
