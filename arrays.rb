
 	#From Computer Science Programming Basics in Ruby

max_index = 32

s = "x"

board = Array.new(max_index + 1) {Array.new(max_index + 1) {s} }

row = 0

column = 0

character_new = 0

while (row < board.size)

	while (column < board[row].size)

		character_new += 1

		if character_new != 7

		print board[row][column]

		column = column+1

		else
			
		board[row][column] = "O"
		
		print board[row][column]

		column = column+1

		character_new = 0

		end

	end

	print "\n"

	column=0

	row=row+1

end

