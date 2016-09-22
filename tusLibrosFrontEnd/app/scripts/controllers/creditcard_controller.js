'use strict';

angular.module('tusLibrosFrontEndApp')
    .controller('CreditCardController', function CreditCardController($scope, $location, CartService) {
        var self = this;
        $scope.creditCardOwner = "";
        $scope.creditCardNumber = "";
        $scope.expirationDate = null;

        $scope.checkOut = function checkOut() {
            CartService.checkOutCart($scope.creditCardOwner, $scope.creditCardNumber, $scope.expirationDate)
                .then(function () {
                    $location.path("/all_purchases");
                }).catch(function (response) {
                alert(response.data.error);
            });
        };

    });
