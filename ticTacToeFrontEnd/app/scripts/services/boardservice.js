'use strict';

/**
 * @ngdoc service
 * @name ticTacToeFrontEndApp.BoardService
 * @description
 * # BoardService
 * Service in the ticTacToeFrontEndApp.
 */
angular.module('ticTacToeFrontEndApp')
    .service('BoardService', function (Board) {
        var self = this;

        self.new = function () {
            return Board.new();
        };
    });
