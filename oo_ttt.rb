require 'pry'

class Player
  attr_accessor :name

  def initialize
    puts "Enter your name"
    #self.player_name = gets.chomp
  end

  def choose_move
    puts "Where do you want to place your move?"
    gets.chomp.to_i
  end

end

class Computer

  def choose_move grid
    puts "computer chose a random move"
    p grid.moves.select { |index,move| move == " " }.keys.sample(1).first

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
      puts "_____|_____|_____"
    end
  end

  def position_is_available? pos
    #implement the check
    puts "Player chose #{pos}"
    #moves.fetch(pos.to_i) != " "
    true
  end

  def place_move position
    #should put the correct sign according to the current player
    self.moves.store(position.to_i, 'x')
    binding.pry
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
    @grid.draw_grid
    player_move = player.choose_move
    if grid.position_is_available? player_move
      #update grid
      @grid.place_move player_move
    end
    computer_move = computer.choose_move @grid
    @grid.place_move computer_move
  end

  def check_for_win

  end

end

game = TicTacToeGame.new

loop do
  game.play_turn
end
