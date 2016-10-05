'use strict';

/**
 * @ngdoc service
 * @name ticTacToeFrontEndApp.Board
 * @description
 * # Board
 * Service in the ticTacToeFrontEndApp.
 */
angular.module('ticTacToeFrontEndApp')
  .service('Board', function ($resource,BACKEND_URL) {
    var BoardClass = $resource(BACKEND_URL + 'boards/:id', {id: '@id'},
        {
          'putMark': {method: 'POST', url: BACKEND_URL + 'carts/:id/putMark'},
        });


    this.new = function nuevo() {
     var board = new BoardClass();
        board.$save();
        return board;
    };

  });
