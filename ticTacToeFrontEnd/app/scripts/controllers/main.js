'use strict';

/**
 * @ngdoc function
 * @name ticTacToeFrontEndApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the ticTacToeFrontEndApp
 */
angular.module('ticTacToeFrontEndApp')
    .controller('MainCtrl', function ($scope, board, _, Mark, ngToast) {

        var self = this;

        $scope.columns = [0, 1, 2];
        $scope.rows = [0, 1, 2];
        $scope.board = board;

        $scope.findSquare = function findSquare(xCoor, yCoor) {
            return _.find($scope.board.squares, function (square) {
                return (square.x === xCoor) && (square.y === yCoor);
            })
        };


        $scope.hasWinner = function hasWinner() {
            return $scope.board.winner != "NO WINNER";
        };

        self.checkForWinnerAndAlert = function checkWinner() {
            if ($scope.hasWinner()) {
                ngToast.success($scope.board.winner);
            }
        };


        self.realizePutMarkAction = function realizePutMarkAction(mark, xCoor, yCoor) {
            mark.position = {x: xCoor, y: yCoor};
            mark.$putMark({id: _.toInteger($scope.board.id)}).then(function (board) {
                $scope.board = board;
                self.checkForWinnerAndAlert();
            }).catch(function () {
                ngToast.danger('GAME IS ALREADY OVER') //TODO: IMPROVE THIS
            });
        };

        $scope.emptySquare = function emptySquare(x, y) {
            return $scope.findSquare(x, y).mark === 'EMPTY'
        };

        $scope.putMark = function putMark(xCoor, yCoor) {
            var mark = new Mark();
            if (!$scope.hasWinner() || $scope.emptySquare(xCoor, yCoor)) {
                self.realizePutMarkAction(mark, xCoor, yCoor);
            }
        };

        $scope.mapToUrl = function (square) {
            var mapper = {
                'X': '/images/cross.png',
                'O': '/images/circle.png',
                'EMPTY': '/images/blank.png'
            };
            return mapper[square.mark];
        };
    });