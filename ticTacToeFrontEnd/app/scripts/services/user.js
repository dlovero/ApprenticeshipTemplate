'use strict';

/**
 * @ngdoc service
 * @name ticTacToeFrontEndApp.User
 * @description
 * # User
 * Factory in the ticTacToeFrontEndApp.
 */
angular.module('ticTacToeFrontEndApp')
  .factory('User', function (BACKEND_URL) {
     return $resource(BACKEND_URL + 'users/:username', {username: '@username'},{})
  });
