'use strict';

angular.module('tusLibrosFrontEndApp')
    .controller('CreditCardController', function CreditCardController($scope, $location, CartService) {
        $scope.creditCardOwner = "";
        $scope.creditCardNumber = "";
        $scope.expirationDate = null;
        $scope.checkOut = function checkOut() {
            CartService.checkout($scope.creditCardOwner.toUpperCase(), $scope.creditCardNumber, $scope.expirationDate)
                .then(function () {
                    $location.path("/all_purchases");
                }).catch(function (response) {
                alert(response.data.error);
            });
        };

    });
