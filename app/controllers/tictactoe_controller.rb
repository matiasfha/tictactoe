class TictactoeController < ApplicationController
	before_action  :initialize, only: [:move]

	def dashboard
		render :layout => 'application'
	end

	def move
		_next_move = jugada params[:xmarked],params[:omarked]
		render :json => { next_move: _next_move,winner:check_game()}
	end

	private

	def initialize
		@places = {
			"a1"=>" ","a2"=>" ","a3"=>" ",
			"b1"=>" ","b2"=>" ","b3"=>" ",
			"c1"=>" ","c2"=>" ","c3"=>" "
		}
		@columns = [
			['a1','a2','a3'],
			['b1','b2','b3'],
			['c1','c2','c3'],
			['a1','b1','c1'],
			['a2','b2','c2'],
			['a3','b3','c3'],
			['a1','b2','c3'],
			['c1','b2','a3']
		]
		@cpu = 'O'
		@user = 'X'
	end

	#Revisa si aun hay movimientos posibles
	def check_moves
		return nil
	end


	#Revisa si el juego se gano o no
	def check_game
		winner = ''
		@columns.each do |column|
			if times_in_column(column,@cpu) == 3
				winner = 'O'
			end
			if  times_in_column(column,@user) == 3
				winner = 'X'
			end
		end
		return winner
	end

	#genera la jugada de la CPU
	def jugada (xmarked,omarked)
		xmarked.each {|elem| @places[elem] = @user } unless xmarked.nil?
		omarked.each {|elem| @places[elem] = @cpu } unless omarked.nil?
		@columns.each do |column|
			if times_in_column(column,@cpu) == 2
				return empty_in_column column
			end

			if times_in_column(column,@user) == 1
				return empty_in_column column
			end
		end

		k = @places.keys
		i = rand(k.length)
		if @places[k[i]] == " "
			return k[i]
		else
			@places.each {|k,v| return k if v == " "}
		end
	end

	#Check el numero de veces que un item aparece en una columna de posible
	#jugada ganadora
	def times_in_column arr,item
		times = 0
		arr.each do |i|
			times += 1 if @places[i] == item
			unless @places[i] == item || @places[i] == ""
				return 0
			end
		end
		times
	end

	def empty_in_column arr
		arr.each do |i|
			if @places[i] == " "
				return i
			end
		end
	end
end
