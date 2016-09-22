'use strict';

/**
 * @ngdoc function
 * @name tusLibrosFrontEndApp.controller:CartshoppingCtrl
 * @description
 * # CartshoppingCtrl
 * Controller of the tusLibrosFrontEndApp
 */
angular.module('tusLibrosFrontEndApp')
    .controller('CartController', function ($scope, $location, CartService, BookService, UserService, zarasa) {


        if (CartService.cartId === null) {
            return $location.path('/login');
        }

        $scope.addBook = function AddBook(isbn, amount) {
            CartService.addBook(isbn, amount).then(function (response) {
                $scope.getItems();
            }).catch(function (response) {
                alert(response.data.error);
                $location.path("/login");
            })
        };

        $scope.getItems = function () {
            CartService.listCart().then(function list_response(listOfItems) {
                $scope.items = listOfItems;
            }).catch(function (response) {
                    alert(response.data.error);
                    $location.path("/login");
            })
        };

        $scope.getCatalog = function getCatalog() {
            BookService.getCatalog().then(function (catalog_list) {
                $scope.catalog = catalog_list
            }).catch(function (response) {
                alert(response.data.error);
                $scope.catalog = [];
            })
        };


        $scope.getItems();
        $scope.getCatalog();

    });
