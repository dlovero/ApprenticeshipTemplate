'use strict';

/**
 * @ngdoc service
 * @name ticTacToeFrontEndApp.Board
 * @description
 * # Board
 * Service in the ticTacToeFrontEndApp.
 */
angular.module('ticTacToeFrontEndApp')
    .service('Board', function ($resource, BACKEND_URL) {

        var BoardClass = $resource(BACKEND_URL + 'boards/:id', {id: '@id'},{});


        this.new = function nuevo() {
            var board = new BoardClass();
            return board.$save().then(function () {
                return board;
            });
        };

    });
