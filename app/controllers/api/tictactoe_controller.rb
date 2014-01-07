class API::TictactoeController < ApplicationController
	before_action  :initialize, only: [:move]


	def move
		_next_move = jugada params[:xmarked],params[:omarked]
		render :json => { next_move: _next_move,winner:check_game(),moves:check_moves()}
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
		return @places.any? { |k,v| v == " "}

	end


	#Revisa si el juego se gano o no
	def check_game
		winner = ''

		@columns.each do |column|
			if  times_in_column(column,@user) == 3
				winner = @user
				break
			end
			if times_in_column(column,@cpu) == 3
				winner = @cpu
				break
			end

		end
		return winner
	end

	#genera la jugada de la CPU
	def jugada (xmarked,omarked)
		xmarked.each {|elem| @places[elem] = @user } unless xmarked.nil?
		omarked.each {|elem| @places[elem] = @cpu } unless omarked.nil?
		move = cpu_move()
		@places[move] = 'O'
		return move
	end

	def cpu_move
		#Check si alguna columna tiene dos marcas de cpu 'O'
		#De ser asi se juega en esa columna
		@columns.each do |column|
			if times_in_column(column,@cpu) == 2
				vacio = column.find { |k,v| @places[k] == " "}
				return vacio if !vacio.nil?
			end
		end
		#Si no existe columna que permita ganar, jugar en alguna posicion libre
		free_positions = @places.find_all{ |k,v| v == " "}
		if free_positions.length > 0
			sample = free_positions.sample.join("")
			return sample
		else
			return ''
		end
	end


	#Check el numero de veces que un item aparece en una columna de posible
	#jugada ganadora
	def times_in_column arr,item
		times = 0
		arr.each do |i|
			times += 1 if @places[i] == item
		end
		times
	end


end
