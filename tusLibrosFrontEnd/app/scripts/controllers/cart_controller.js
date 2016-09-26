'use strict';

/**
 * @ngdoc function
 * @name tusLibrosFrontEndApp.controller:CartshoppingCtrl
 * @description
 * # CartshoppingCtrl
 * Controller of the tusLibrosFrontEndApp
 */
angular.module('tusLibrosFrontEndApp')
    .controller('CartController', function ($scope, $location, catalog, cart, CartService, BookService) {


        $scope.cart = cart;

        $scope.addBook = function addBook(bookSelected, amount) {
            CartService.addBook(bookSelected.isbn, amount).then(function () {
            }).catch(function (response) {
                alert(response.data.error);
                $location.path("/login");
            })
        };

        $scope.getItems = function () {
            CartService.listCart().catch(function () {
                alert('Vuelva a ingresar para volver a comprar');
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

        $scope.catalog = catalog;

    });




/*           var itemsOfACart = $scope.cart.items.filter(function (item) {
 return item.isbn === bookSelected.isbn;
 });
 if (itemsOfACart.length === 0) {
 $scope.cart.items.push({
 title: bookSelected.title, isbn: bookSelected.isbn,
 amount_of_books: amount, price: bookSelected.price
 });
 } else {
 itemsOfACart[0].amount_of_books = itemsOfACart[0].amount_of_books+amount;
 } */