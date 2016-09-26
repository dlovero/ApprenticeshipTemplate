'use strict';

/**
 * @ngdoc service
 * @name tusLibrosFrontEndApp.User
 * @description
 * # User
 * Service in the tusLibrosFrontEndApp.
 */
angular.module('tusLibrosFrontEndApp')
    .service('UserService', function UserService($http, $location, BACKEND_URL) {

        var self = this;

        self.set_user_and_password = function (userId, password) {
            self.userId = userId;
            self.password = password;
        };


        self.listPurchases = function listPurchases() {
            return $http.get(BACKEND_URL + 'users' + '/' + self.userId + '/sales', {
                    params: {
                        password: self.password
                    }}
            ).then(function (response) {
                return response.data;
            })
        };

    });
