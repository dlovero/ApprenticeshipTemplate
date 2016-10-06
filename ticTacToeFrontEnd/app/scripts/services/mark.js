'use strict';

/**
 * @ngdoc service
 * @name ticTacToeFrontEndApp.Mark
 * @description
 * # Mark
 * Factory in the ticTacToeFrontEndApp.
 */
angular.module('ticTacToeFrontEndApp')
    .factory('Mark', function ($resource, BACKEND_URL) {
        return $resource(BACKEND_URL + 'boards/:id',{},
            {
                putMark: {method: 'POST', url: BACKEND_URL + 'boards/:id/putMark'}
            });
    });
