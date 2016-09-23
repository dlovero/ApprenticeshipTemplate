'use strict';

/**
 * @ngdoc service
 * @name tusLibrosFrontEndApp.login
 * @description
 * # login
 * Service in the tusLibrosFrontEndApp.
 */

angular.module('tusLibrosFrontEndApp')
    .service('CartService', function CartService($http, CartProvider, SalesService, BACKEND_URL) {

            var self = this;
            self.currentCart = null;

            self.login = function login(userId, password) {
                self.currentCart = CartProvider.new(userId, password);
                return self.currentCart.$save();
            };

///////////////////////////////////////////////////////////////////////
            this.listCart = function listCart() {
                return self.currentCart.$get();

            };
///////////////////////////////////////////////////////////////////////
            this.addBook = function addBook(isbn, amount) {
               return  self.currentCart.$addBook({
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
    )
;
