'use strict';

/**
 * @ngdoc service
 * @name ticTacToeFrontEndApp.Mark
 * @description
 * # Mark
 * Factory in the ticTacToeFrontEndApp.
 */
angular.module('ticTacToeFrontEndApp')
    .factory('Mark', function ($resource,BACKEND_URL) {
        var MarkClass = $resource(BACKEND_URL + 'boards/',
            {
                'putMark': {method: 'POST', url: BACKEND_URL + 'boards/:id/putMark'}
            });

        return MarkClass;
    });
