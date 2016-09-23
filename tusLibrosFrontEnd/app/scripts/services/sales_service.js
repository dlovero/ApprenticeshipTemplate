'use strict';

/**
 * @ngdoc service
 * @name tusLibrosFrontEndApp.User
 * @description
 * # User
 * Service in the tusLibrosFrontEndApp.
 */
angular.module('tusLibrosFrontEndApp')
    .service('SalesService', function SalesService($http, $location, BACKEND_URL) {
        var self = this;
        self.userId = null;
        self.password = "";

        self.listPurchases = function listPurchases() {
            return $http.get(BACKEND_URL + 'listPurchases', {
                params: {
                    userId: self.userId,
                    password: self.password
                }
            }).then(function (response) {
                return response.data;
            })
        };

        self.update = function update(user, password) {
            self.userId = user;
            self.password = password;
        };
    });
