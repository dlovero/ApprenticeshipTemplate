'use strict';

/**
 * @ngdoc function
 * @name ticTacToeFrontEndApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the ticTacToeFrontEndApp
 */
angular.module('ticTacToeFrontEndApp')
    .controller('MainCtrl', function ($scope, board, _, Mark) {

        $scope.columns = [0, 1, 2];
        $scope.rows = [0, 1, 2];
        $scope.board = board;

        $scope.findSquare = function findSquare(xCoor, yCoor) {
            return _.find($scope.board.squares, function (square) {
                return (square.x === xCoor) && (square.y === yCoor);
            })
        };

        $scope.putMark = function putMark(xCoor, yCoor) {
            var mark=new Mark();
            mark.position={x:xCoor,y:yCoor};
            mark.$putMark($scope.board.id);
        };

        $scope.mapToUrl = function (square) {
            var mapper = {
                'X': 'http://freevector.co/wp-content/uploads/2014/08/63694-delete-cross-200x200.png',
                'O': 'http://freevector.co/wp-content/uploads/2014/04/64299-circumference-200x200.png',
                'EMPTY': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Tv_blank.svg/2000px-Tv_blank.svg.png'
            };

            return mapper[square.mark];
        }
    });