'use strict';

/**
 * @ngdoc function
 * @name tusLibrosFrontEndApp.controller:CartshoppingCtrl
 * @description
 * # CartshoppingCtrl
 * Controller of the tusLibrosFrontEndApp
 */
angular.module('tusLibrosFrontEndApp')
    .controller('CartController', function ($scope, $location, CartService, BookService) {

        $scope.cart = CartService.cart;

        if (CartService.currentCart === null) {
            return $location.path('/login');
        }

        $scope.addBook = function addBook(bookSelected, amount) {
            CartService.addBook(bookSelected.isbn, amount).then(function () {
                var itemsOfACart = $scope.cart.items.filter(function (item) {
                   return item.isbn === bookSelected.isbn;
                });
                debugger
                if (itemsOfACart.length === 0) {
                    $scope.cart.items.push({
                        title: bookSelected.title, isbn: bookSelected.isbn,
                        amount_of_books: amount, price: bookSelected.price
                    });
                } else {
                    itemsOfACart[0].amount_of_books = itemsOfACart[0].amount_of_books+amount;
                }
            }).catch(function (response) {
                alert(response.data.error);
                $location.path("/login");
            })
        };

        $scope.getItems = function () {
            CartService.listCart().then(function list_response(listOfItems) {

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
