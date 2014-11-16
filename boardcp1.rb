
 	# Adapted from Computer Science Programming Basics in Ruby ch. 12
class Board

BOARD_MAX_INDEX = 2  # Having at least the first letter (or all) of a variable name capitalized makes it a constant

EMPTY_POS = " "

#COMPUTER_PLAYER = computer_set

#HUMAN_PLAYER = human_set

def initialize(current_player)

	@current_player = current_player

	@board = Array.new(BOARD_MAX_INDEX + 1) {Array.new(BOARD_MAX_INDEX + 1) {EMPTY_POS} }

#puts "You are playing as #{HUMAN_PLAYER}, and the computer is playing as #{COMPUTER_PLAYER}."

end

def display

	puts "+ - - - - - +"

	for row in 0..BOARD_MAX_INDEX

	print "|"

	for col in 0..BOARD_MAX_INDEX

		s = @board[row][col]
		if s == EMPTY_POS
			print " "
			print col + ( row *3 ) + 1 # clever math prints out numbers 1 - 9 on empty spaces only
		else
			print " "
			print s

		end

		print " |"
	end
	puts "\n+ - - - - - +"
end

end

def board_full

for row in 0..BOARD_MAX_INDEX
for col in 0..BOARD_MAX_INDEX
if @board[row][col] == EMPTY_POS
return false
end
end
end
return true
end

def available_corner

if (@board[0][0] == EMPTY_POS) || (@board[2][0] == EMPTY_POS) || (@board[0][2] == EMPTY_POS) || (@board[2][2] == EMPTY_POS)
puts "corner avaiolable"
return true
else
	puts "corner unavaiolable"
return false
end
end	

def ask_player_for_move(current_player)
	if current_player == COMPUTER_PLAYER
		computer_move(current_player)
	else
		human_move(current_player)
	end
end

def computer_move(current_player)
row = -1
col = -1
@found = "F"

check_rows(COMPUTER_PLAYER, @found)

check_cols(COMPUTER_PLAYER, @found)

check_diagonals(COMPUTER_PLAYER, @found)

check_rows(HUMAN_PLAYER, @found)

check_cols(HUMAN_PLAYER, @found)

check_diagonals(HUMAN_PLAYER, @found)

	if @found == "F"
	
		if @board[1][1] == EMPTY_POS
		@board[1][1] = current_player
		@found = "Y"
		end

		if available_corner() && @found == "F"
		puts (@found)
		b = false
		until b
			puts "picking corner"
			arr = [0,2]
			row = arr[rand(2)]
			col = arr[rand(2)]

			if 	@board[row][col] == EMPTY_POS
				@board[row][col] = current_player
				b = true
			end	
		
		end
			
		elsif @found == "F"

		c = false
		until c
		row = rand(@board.size)
		col = rand(@board.size)
		if @board[row][col] == EMPTY_POS
		@board[row][col] = current_player
		c = true
		end
	end
	
	
end

end
end


def human_move(current_player)
	played = false

	while played != true

		puts current_player + ", please select a move"

		move = gets.to_i - 1


		col = move % @board.size

		row = (move - col) / @board.size

		if validate_position(row, col)
			@board[row][col] = current_player
			played = true
		end
	end
end


def check_rows(symbol, found)
	if @found == "Y"
		return 
	else

		for row_index in 0..BOARD_MAX_INDEX

			if @found != "Y" && @board[row_index].include?(EMPTY_POS)
				
				if !(@board[row_index].include?(symbol))

				puts "#{symbol}not in row #{row_index.to_s}"
				  # we are looking for the opportunity for a win, so any opposite symbols in this col cause a break

				elsif @board[row_index][0] == symbol and @board[row_index][2] == symbol 
				@board[row_index][1] = COMPUTER_PLAYER
				puts "row win possible by #{symbol} in row #{row_index}!"
				
				 @found = "Y"
				 return
				elsif @board[row_index][0] == symbol and @board[row_index][1] == symbol 
				@board[row_index][2] = COMPUTER_PLAYER
				puts "row win possible by #{symbol} in row #{row_index}!"
				
				@found = "Y"
				return 
				elsif @board[row_index][1] == symbol and @board[row_index][2] == symbol
				@board[row_index][0] = COMPUTER_PLAYER
		 		puts "row win possible by #{symbol} in row #{row_index}!"
				 @found = "Y"
				 return
 				else
 					puts "no wins possible for #{symbol} in #{row_index}"
				
				end
			end
		end
	end
end
	



def check_cols(symbol, found)
	if @found == "Y"
		return 
	else
		ary_col = [[], [], []]
		for row_index in 0..BOARD_MAX_INDEX
			for col_index in 0..BOARD_MAX_INDEX
				ary_col[col_index].push(@board[row_index][col_index])

			
			end
		end	

		for col_index in 0..BOARD_MAX_INDEX

			if @found != "Y" && ary_col[col_index].include?(EMPTY_POS)

				if !(ary_col[col_index].include?(symbol))
					puts "#{symbol}not in column #{col_index.to_s}"

				

				elsif ary_col[col_index][0] == symbol and ary_col[col_index][2] == symbol
				@board[1][col_index] = COMPUTER_PLAYER
				puts "col win possible by #{symbol} in #{col_index}!"
				

				 @found = "Y"
				 return
				elsif ary_col[col_index][0] == symbol and ary_col[col_index][1] == symbol 
				@board[2][col_index] = COMPUTER_PLAYER
				puts "col win possible by #{symbol} in #{col_index}!"
				
				@found = "Y"
				return 
				elsif ary_col[col_index][1] == symbol and ary_col[col_index][2] == symbol
				@board[0][col_index] = COMPUTER_PLAYER
		 		puts "col win possible by #{symbol} in #{col_index}!"
				 @found = "Y"
				 return
 				else
 					puts "no wins possible for #{symbol} in col #{col_index}"
				
				end
			end
		end
	end
end
	

def check_diagonals(symbol, found)
	if found == "Y"
		return
	end	
end






def winner_cols
	for col_index in 0..BOARD_MAX_INDEX
		first_symbol = @board[0][col_index]
		for row_index in 1..BOARD_MAX_INDEX
			if first_symbol != @board[row_index][col_index]
				break 									#break without returning winner if we find symbols not matching along a col
			elsif row_index == BOARD_MAX_INDEX and first_symbol != EMPTY_POS
				return first_symbol # returns symbol that is in first position in row as winner by col method
				
			end
		end
	end
	return 
end


def winner_rows
	for row_index in 0..BOARD_MAX_INDEX
		first_symbol = @board[row_index][0]
		for col_index in 1..BOARD_MAX_INDEX
			if first_symbol != @board[row_index][col_index]
				break									#break without returning winner if we find symbols not matching down a row
			elsif col_index == BOARD_MAX_INDEX and first_symbol != EMPTY_POS
				return first_symbol # returns symbol that is in first position in row as winner by row method

			end
		end
	end
	return
end

def winner_diagonals
	first_symbol = @board[0][0]
	for index in 1..BOARD_MAX_INDEX
	
		if first_symbol != @board[index][index]
			break
		elsif index == BOARD_MAX_INDEX and first_symbol != EMPTY_POS
			return first_symbol
		end
	end

	first_symbol = @board[0][BOARD_MAX_INDEX]

	row_index = 0
	col_index = BOARD_MAX_INDEX

	while row_index < BOARD_MAX_INDEX
		row_index += 1
		col_index -= 1

		if first_symbol != @board[row_index][col_index]
			break

		elsif row_index == BOARD_MAX_INDEX and first_symbol != EMPTY_POS
			return first_symbol
		end

	end
	return
end

def winner

winner = winner_rows()

if winner
return winner
end
winner = winner_cols()

if winner
return winner
end
winner = winner_diagonals()

if winner
return winner
end

#  if the method hasn't returned yet, then no winners yet, so return nul

return

end

def validate_position(row, col)

	if row <= @board.size and col <= @board.size

		if @board[row][col] == EMPTY_POS
			return true

		#else
		#	puts "That position already contains a #{@board[row][col]} Pick again."

		end
			#puts "Invalid position option.  Pick again."
		end
		return false
	end

	def get_next_turn
		if @current_player == 'X'
			@current_player = 'O'
		else
			@current_player = 'X'
		end
		return @current_player
	end

end





