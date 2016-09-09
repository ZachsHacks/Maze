class Maze

	def initialize(x, y)
		@row = x
		@col = y
		@position = {}
		load(x, y)
	end

	def load(row , col)
		puts "Please enter a maze: (For example: \"111111111100010001111010101100010101101110101100000101111011101100000101111111111\")"
		print "> "
		@maze = $stdin.gets
		@maze = turn_into_maze(@maze, row)
	end

	def turn_into_maze(maze, row)
		input = Array.new
		index = 0
		y = 0
		for x in 0..maze.length-1
			input.push(maze[x])
			index += 1
		end
		input = input.each_slice(row).to_a
		@position = get_positions(input)
		return input;
	end

	def get_positions(input)
		index = 0
		for i in 0..(@col)-1
			for j in 0..(@col)-1
				position = @maze[i][j]
				if position == "0"
					@position[index] = [i, j]
					index+=1
				end
			end
		end
	end


	def display
		for i in 0..(@col)-1
			for j in 0..(@col)-1
				position = @maze[i][j]
				if position == "1"
					print "* "
				elsif position =="2"
					print "x "
				else print "  "
				end
			end
			print "\n"
		end
	end

	def solve(beg_x, beg_y, end_x, end_y) #Doesn't work (I was trying Breadth First Search)
		@path = []
		queue = Queue.new
		queue.push([beg_x, beg_y])
		while !queue.empty? do
			current = queue.pop()
			current_x = current[0]
			current_y = current[1]
			@maze[current_x][current_y] = "2"
			@path.push([current_x, current_y])
			if current_x == end_x && current_y == end_y
				return true
			else
				queue.push([current_x+1,current_y]) if position_exists(current_x+1, current_y)
				queue.push([current_x,current_y-1]) if position_exists(current_x, current_y-1)
				queue.push([current_x-1,current_y]) if position_exists(current_x-1, current_y)
				queue.push([current_x ,current_y+1]) if position_exists(current_x, current_y+1)
			end
		end
		return false
	end

	def trace(beg_x, beg_y, end_x, end_y)
		if solve(beg_x, beg_y, end_x, end_y)
			puts "There is a path from [#{beg_x}, #{beg_y}] to [#{end_x}, #{end_y}]."
			puts "Here it is: #{@path.to_s}"
		else puts "There is no path from [#{beg_x}, #{beg_y}] to [#{end_x}, #{end_y}]."
		end
	end

	def position_exists(x, y)
		if @maze[x][y] == "0"
			return true
		else return false
		end
	end

	maze = Maze.new(9,9)
	maze.trace(1,1,5,1)
	maze.display
end
