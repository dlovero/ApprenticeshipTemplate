'use strict';

/**
 * @ngdoc service
 * @name tusLibrosFrontEndApp.login
 * @description
 * # login
 * Service in the tusLibrosFrontEndApp.
 */

angular.module('tusLibrosFrontEndApp')
    .service('CartService', function CartService($http, UserService, BACKEND_URL) {
            var self = this;
            self.cartId = null;
///////////////////////////////////////////////////////////////////////
            this.submit = function submit(userId, password) {
                return $http.post(BACKEND_URL + 'createCart', {
                    login: {
                        id: userId,
                        password: password
                    }
                }).then(function (response) {
                    self.cartId = response.data.cart_id;
                    UserService.update(userId,password);
                })
            };
///////////////////////////////////////////////////////////////////////
            this.listCart = function listCart() {
                return $http.get(BACKEND_URL + 'listCart',
                    {params: {cartId: self.cartId}}
                ).then(function (response) {
                    return response.data;
                })
            };
///////////////////////////////////////////////////////////////////////
            this.addBook = function addBook(isbn, amount) {
                return $http.post(BACKEND_URL + 'addToCart', {
                    cartId: self.cartId,
                    bookIsbn: isbn,
                    bookQuantity: amount
                })
            };
////////////////////////////////////////////////////////////////////////
            this.checkOutCart = function checkout(creditCardOwner, creditCardNumber, expirationDate) {
                return $http.post(BACKEND_URL + 'checkOutCart', {
                    cartId: self.cartId,
                    credit_card: {
                        credit_card_number: creditCardNumber,
                        credit_card_owner: creditCardOwner,
                        expiration_date: expirationDate
                    }
                });
            };

        }
    );
