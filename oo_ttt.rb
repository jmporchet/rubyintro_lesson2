class Player
  attr_accessor :name

  def choose_move
    puts "Where do you want to place your move?"
    gets.chomp.to_i
  end
end

class Computer
  def choose_move grid
    grid.moves.select { |index,move| move == " " }.keys.sample(1).first
  end
end

class Grid
  attr_accessor :moves

  def initialize
    self.moves = {1=>" ", 2=>" ", 3=>" ", 4=>" ", 5=>" ", 6=>" ", 7=>" ", 8=>" ", 9=>" " }
  end

  def draw_grid
    system ("cls")

    3.times do |line|
      puts "     |     |     "
      puts "  #{self.moves.fetch(line*3+1)}  |  #{self.moves.fetch(line*3+2)}  |  #{self.moves.fetch(line*3+3)}  "
      puts (line != 2) ? "_____|_____|_____" : "     |     |     "
    end
  end

  def position_is_available? pos
    return false if pos == 0
    @moves.fetch(pos.to_i) == " "
  end

  def place_move position, player_object
    marker = (player_object.is_a? Player) ? 'x' : 'o'
    self.moves.store(position.to_i, marker)
  end
end

class TicTacToeGame
  attr_accessor :player, :computer, :grid

  WINNING_MOVES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

  def initialize
    self.player = Player.new
    self.computer = Computer.new

    self.grid = Grid.new
  end

  def play_turn
    
    player_choice = player.choose_move
    if grid.position_is_available? player_choice
    #update grid
      @grid.place_move player_choice, @player

      computer_choice = computer.choose_move @grid
      @grid.place_move computer_choice, @computer
      @grid.draw_grid
    else
      puts "This wasn't a valid position. Please try again."
    end
  end

  def check_for_win
    player_moves = @grid.moves.select { |i,m| m == 'x' }.keys
    computer_moves = @grid.moves.select { |i,m| m == 'o' }.keys

    WINNING_MOVES.each do |line|
      return "You won!" if @grid.moves.values_at(*line).count('x') == 3 
      return "You lost!" if @grid.moves.values_at(*line).count('o') == 3 
    end
    nil
  end
end

game = TicTacToeGame.new

loop do
  game.play_turn
  result = game.check_for_win
  if result != nil
    puts result
    exit
  end
end
