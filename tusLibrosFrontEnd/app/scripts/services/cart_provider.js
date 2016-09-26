'use strict';

/**
 * @ngdoc service
 * @name tusLibrosFrontEndApp.Cart
 * @description
 * # Cart
 * Service in the tusLibrosFrontEndApp.
 */
angular.module('tusLibrosFrontEndApp')
    .service('CartProvider', function CartProvider($resource, BACKEND_URL) {

        var CartClass = $resource(BACKEND_URL + 'carts/:cartId', {cartId: '@cart_id'},
            {
                'addBook': {method: 'POST', url: BACKEND_URL + 'carts/:cartId/addBook'},
                'checkout': {method: 'POST', url: BACKEND_URL + 'carts/:cartId/checkout'}
            });

        this.new = function nuevo(userId, password) {
            return new CartClass({login: {id: userId, password: password}});
        };
    });
