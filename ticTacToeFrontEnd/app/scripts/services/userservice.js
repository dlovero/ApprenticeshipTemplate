'use strict';

/**
 * @ngdoc service
 * @name ticTacToeFrontEndApp.UserService
 * @description
 * # UserService
 * Service in the ticTacToeFrontEndApp.
 */
angular.module('ticTacToeFrontEndApp')
    .service('UserService', function (User) {
        var self = this;

        self.currentUser = User;

        self.register = function register(username) {
            self.currentUser.$save({username: username});
        };

        self.login = function login(username){
            self.currentUser.$get({username: username});
        };

    });
