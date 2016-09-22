'use strict';

/**
 * @ngdoc service
 * @name tusLibrosFrontEndApp.login
 * @description
 * # login
 * Service in the tusLibrosFrontEndApp.
 */

angular.module('tusLibrosFrontEndApp')
    .service('CartService', function CartService($http) {
        var self = this;
///////////////////////////////////////////////////////////////////////
        this.submit = function submit(userId, password) {
            return $http.post('http://localhost:3000/createCart', {
                login: {
                    id: userId,
                    password: password
                }
            }).then(function (response) {
                self.cartId = response.data.cart_id;
            })
        };
///////////////////////////////////////////////////////////////////////
        this.listCart = function listCart() {
            return $http.get('http://localhost:3000/listCart',
                {params: {cartId: self.cartId}}
            ).then(function (response) {
                return response.data;
            })
        };
///////////////////////////////////////////////////////////////////////
        this.addBook = function addBook(isbn, amount) {
            return $http.post('http://localhost:3000/addToCart', {
                cartId: self.cartId,
                bookIsbn: isbn,
                bookQuantity: amount
            })
        };
////////////////////////////////////////////////////////////////////////
        this.checkOutCart = function checkout(creditCardOwner, creditCardNumber, expirationDate) {
            return $http.post('http://localhost:3000/checkOutCart', {
                    cartId: self.cartId,
                    credit_card: {
                        credit_card_number: creditCardNumber,
                        credit_card_owner: creditCardOwner,
                        expiration_date: expirationDate
                    }
                }).then(function(){
                  console.log('COBRADO');
                });
        };

    });
