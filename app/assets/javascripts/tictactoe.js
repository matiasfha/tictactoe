(function () {
	'use strict';
}());

angular.module('tictactoe', ['ngResource', 'ngRoute'])


// routes
.config(['$routeProvider', '$locationProvider', '$httpProvider', function ($routeProvider, $locationProvider, $httpProvider) {
	$routeProvider.when('/', {
		controller: 'Dashboard',
		templateUrl: '/assets/templates/dashboard.html'
	});

	$locationProvider.html5Mode(false);

	var csrf = $('meta[name="csrf-token"]').attr("content");
	$httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = csrf;

}])

// Resource for server requests
.factory('MoveResource', ['$resource', function ($resource) {
	return $resource('/api/move.json', {}, {
		play: {method: 'POST', params: {}, isArray: false}
	});
}])

// Controllers
.controller('Dashboard', ['$scope', '$resource', 'MoveResource', '$route', function ($scope, $resource, MoveResource, $route) {


	$scope.playAgain = function () {
		//Reload the view
		$route.reload();
	}

	var play = function(omarked,xmarked){
		//Enviar la jugada del usuario
		MoveResource.play({omarked:omarked,xmarked:xmarked},function (data) {
			//Marcar la jugada de la CPU
			switch(data.winner){
				case '':
					var $next = $('#'+data.next_move);
					$next.addClass('o-marked');
					$next.append($('<span class="osign">O</span>'));
					if(!data.moves){
						$scope.winner = 'No quedan mas movimientos';
						$scope.gameOver = true;
					}
					break;
				case 'X':
					$scope.winner = 'Has Ganado!!';
					$scope.gameOver = true;
					break;
				case 'O':
					var $next = $('#'+data.next_move);
					$next.addClass('o-marked');
					$next.append($('<span class="osign">O</span>'));
					$scope.winner = 'Has perdido :(';
					$scope.gameOver = true;
					break;
			}
		});
	}

	$scope.user_mark = function (event) {
		$cell = $(event.currentTarget);

		if(!$cell.hasClass('x-marked') && !$cell.hasClass('o-marked') && !$scope.gameOver){
			//Marcar la jugada del usuario
			$cell.append($('<span class="xsign">X</span>'));
			$cell.addClass('x-marked');
			var xmarked = [];
			$.each($('div.x-marked'),function(id,cell){
				xmarked.push($(cell).attr('id'));
			});
			var omarked = [];
			$.each($('div.o-marked'),function(id,cell){
				omarked.push($(cell).attr('id'));
			});
			play(omarked,xmarked);

		}

	}

}]);
