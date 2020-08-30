$board = [["   ", "1", "  2", "  3"], ["A ", "[ ]", "[ ]", "[ ]"], 
         ["B ", "[ ]", "[ ]", "[ ]"], ["C ", "[ ]", "[ ]", "[ ]"]]
$tracker = [["" ,"" ,""], ["" ,"" ,""], ["" ,"" ,""]]
$winner = false

class Game
  def self.display
    display = $board.each { |block| puts block.join }
  end

  def self.start
    puts "First player's name?: "
    first_player = gets.chomp
    player_x = Players.new(first_player, "[X]")
    puts "Second player's name?: "
    second_player = gets.chomp
    player_o = Players.new(second_player, "[O]")
    until $winner
      player_x.turns(player_x)
      player_o.turns(player_o)
    end
  end 
end

class Players < Game
  attr_reader :token
  
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
    if coordinates_array.include?("A") && $tracker[0][coordinates_array[1].to_i - 1] == ""
      $board[1].delete_at(coordinates_array[1].to_i)
      $board[1].insert(coordinates_array[1].to_i, self.token)
      $tracker[0].insert(coordinates_array[1].to_i - 1, self.token)
    elsif coordinates_array.include?("B") && $tracker[1][coordinates_array[1].to_i - 1] == ""
      $board[2].delete_at(coordinates_array[1].to_i)
      $board[2].insert(coordinates_array[1].to_i, self.token)
      $tracker[1].insert(coordinates_array[1].to_i - 1, "Taken")
    elsif coordinates_array.include?("C") && $tracker[2][coordinates_array[1].to_i - 1] == ""
      $board[3].delete_at(coordinates_array[1].to_i)
      $board[3].insert(coordinates_array[1].to_i, self.token)
      $tracker[2].insert(coordinates_array[1].to_i - 1, "Taken")
    else
      puts "Choose again: "
      player_choise = gets.chomp
      choises(player_choise)
    end
  end

  def turns(player)
    Game.display
    puts "#{player.name}'s turn. Choose wisely (e.g. B2)"
    choise = gets.chomp
    choises(choise)
    Game.display
  end
end

Game.start
p $tracker
