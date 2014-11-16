
 	#From Computer Science Programming Basics in Ruby

require_relative 'boardcp1.rb'

puts "Tic-Tac-Toe"

players = ["X", "O"]

human_set = players[rand(2)]

	if human_set == players[0]

		computer_set = players[1]

	else

		computer_set = players[0]

	end

player_rand = [human_set, computer_set]

current_player = player_rand[rand(2)]
puts current_player
b = Board.new(current_player)

Board::HUMAN_PLAYER = human_set
Board::COMPUTER_PLAYER = computer_set


b.display()
puts

while not b.board_full() and not b.winner()
	b.ask_player_for_move(current_player)
	current_player = b.get_next_turn()
	b.display()
	puts

end

if b.winner()
	puts "Player " + b.get_next_turn() + " wins."

	else 

	puts "Tie Game."

	end

	puts "Game Over"













