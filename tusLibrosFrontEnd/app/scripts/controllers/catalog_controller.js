'use strict';

/**
 * @ngdoc function
 * @name tusLibrosFrontEndApp.controller:CatalogCtrl
 * @description
 * # CatalogCtrl
 * Controller of the tusLibrosFrontEndApp
 */
angular.module('tusLibrosFrontEndApp')
    .controller('CatalogController', function CatalogController($scope, BookService) {
        BookService.getCatalog().then(function (catalog_list) {
            $scope.catalog = catalog_list
        }).catch(function (response) {
            alert(response.error);
            $scope.catalog = [];
        })
    });
