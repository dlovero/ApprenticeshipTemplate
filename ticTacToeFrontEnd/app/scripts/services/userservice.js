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

        self.currentUser = new User();

        self.register = function register(username) {
          return self.currentUser.$save({username: username});
        };

        self.login = function login(username){
            return self.currentUser.$get({username: username});
        };

    });
