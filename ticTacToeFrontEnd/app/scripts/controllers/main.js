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

        $scope.putMark = function putMark(xCoor, yCoor) {
            var mark = new Mark();
            mark.position = {x: xCoor, y: yCoor};
            mark.$putMark({id: _.toInteger($scope.board.id)}).then(function (board) {
                if (!$scope.hasWinner()) {
                    $scope.board = board;
                    self.checkForWinnerAndAlert();
                }
            }).catch(function () {
                ngToast.danger('GAME IS ALREADY OVER') //TODO: IMPROVE THIS
            });
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