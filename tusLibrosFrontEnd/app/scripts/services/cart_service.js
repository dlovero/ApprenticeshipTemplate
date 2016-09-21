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
        self.cart_id = null;
///////////////////////////////////////////////////////////////////////
        this.submit = function submit(user_id, password) {
            return $http.post('http://localhost:3000/createCart', {
                login: {
                    id: user_id,
                    password: password
                }
            }).then(function (response) {
                self.cart_id = response.data.cart_id;
            })
        }
///////////////////////////////////////////////////////////////////////
        this.list_cart = function list_cart() {
            return $http.get('http://localhost:3000/listCart',
                {params: {cartId: '1'}}).then(function (response) {
                return response.data;
            })
        }
    });
