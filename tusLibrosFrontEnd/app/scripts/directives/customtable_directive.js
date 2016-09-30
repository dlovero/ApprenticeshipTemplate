'use strict';

/**
 * @ngdoc directive
 * @name tusLibrosFrontEndApp.directive:CustomTable
 * @description
 * # CustomTable
 */
angular.module('tusLibrosFrontEndApp')
    .directive('customTable', function () {
        return {
            templateUrl: '../../custom_table.html',
            restrict: 'E',
            scope: {
                content: '=content',
                operations: '=operations',
                columns: '=columns'
            },
            link: function(scope){
            }

        };
    });
