$board = [["   ", "1", "  2", "  3"], ["A ", "[ ]", "[ ]", "[ ]"], 
         ["B ", "[ ]", "[ ]", "[ ]"], ["C ", "[ ]", "[ ]", "[ ]"]]
$tracker = [["a1" ,"b1" ,"c1" ], ["a2" ,"b2" ,"c2" ], ["a3" ,"b3" ,"c3" ]]
$winner = false
$counter = 0

class Game
  def self.display
    display = $board.each { |block| puts block.join }
  end

  def self.tie
    if $counter == 9
      $winner = true
      puts "It's a tie!"
    end
  end

  def self.start
    puts "First player's name?: "
    first_player = gets.chomp
    player_x = Players.new(first_player, "[X]")
    puts "Second player's name?: "
    second_player = gets.chomp
    player_o = Players.new(second_player, "[O]")
    until $winner == true
      player_x.turns(player_x)
      $winner ? break : player_o.turns(player_o)
    end
  end
end

class Players < Game
  def initialize(name, token)
    @name = name
    @token = token
  end
  
  def name
    @name.capitalize
  end

  def token
    @token
  end

  def choises(player_choise)
    coordinates_array = player_choise.upcase.split("")
    col = coordinates_array[1].to_i
    if coordinates_array.include?("A") && !$board[1][col].match?(/X|O/)
      record(1, col)
    elsif coordinates_array.include?("B") && !$board[2][col].match?(/X|O/)
      record(2, col)
    elsif coordinates_array.include?("C") && !$board[3][col].match?(/X|O/)
      record(3, col)
    else
      puts ´Choose again: ´
      player_choise = gets.chomp
      choises(player_choise)
    end
  end

  def record(row, col)
    $board[row].delete_at(col)
    $board[row].insert(col, self.token)
    $tracker[row-1].delete_at(col-1)
    $tracker[row-1].insert(col-1, self.token)
  end

  def turns(player)
    Game.display
    choose()
    winner() 
    $winner ? return : $counter += 1
    Game.tie
  end

  def choose
    puts "#{self.name}'s turn. Choose wisely (e.g. B2)"
    choise = gets.chomp
    choise.size == 2 ? choises(choise) : choose()
  end

  def winner
    i = 0
    # Three in a row
    $tracker.each { |row| 
      if row == ["#{self.token}", "#{self.token}", "#{self.token}"]
        $winner = true
        puts "#{self.name} won R!"
      end
    }
    # Three in a col
    for j in (0..2)
      if $tracker[i][j] == $tracker[i+1][j] && $tracker[i+1][j] == $tracker[i+2][j]
        $winner = true
        puts "#{self.name} won!"
      end
    end
    # Diagonal
    if $tracker[i][i] == $tracker[i+1][i+1] && $tracker[i+1][i+1] == $tracker[i+2][i+2]
      $winner = true
      puts "#{self.name} won!"    
    elsif $tracker[i][i+2] == $tracker[i+1][i+1] && $tracker[i+1][i+1] == $tracker[i+2][i]
      $winner = true
      puts "#{self.name} won!"
    end
  end
end

Game.start
