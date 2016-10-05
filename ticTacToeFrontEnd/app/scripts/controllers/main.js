'use strict';

/**
 * @ngdoc function
 * @name ticTacToeFrontEndApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the ticTacToeFrontEndApp
 */
angular.module('ticTacToeFrontEndApp')
  .controller('MainCtrl', function ($scope) {
    $scope.rows = [[{mark: ' '}, {mark: ' '}, {mark: ' '}],
        [{mark: ' '}, {mark: 'X'}, {mark: ' '}],
        [{mark: ' '}, {mark: ' '}, {mark: ' '}]];

    $scope.mapToUrl = function (square) {
        var mapper = {
            'X': 'http://freevector.co/wp-content/uploads/2014/08/63694-delete-cross-200x200.png',
            'O': 'http://freevector.co/wp-content/uploads/2014/04/64299-circumference-200x200.png',
            ' ': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Tv_blank.svg/2000px-Tv_blank.svg.png'
            };

        return mapper[square.mark];
    }
  });
