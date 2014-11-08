require 'pry'

class RPSObject
  def initialize
  end

  def beats?
  end

  def to_s
  end
end

class Paper < RPSObject
  def beats? other_object
    other_object.to_s == 'Rock' ? true : false
  end

  def to_s
    'Paper'
  end
end

class Rock < RPSObject
  def beats? other_object
    other_object.to_s == 'Scissors' ? true : false
  end

  def to_s
    'Rock'
  end
end

class Scissors < RPSObject
  def beats? other_object
    other_object.to_s == 'Paper' ? true : false
  end

  def to_s
    'Scissors'
  end
end

class Player
  attr_accessor :moves


  def choose
    choices = ['p','r','s']

    begin
      puts "Choose one: (P/R/S)"
      move = gets.chomp.downcase
      case move
      when "p"
        return Paper.new
      when "r"
        return Rock.new
      when "s"
        return Scissors.new
      else
        nil
      end
    end until choices.include? move
  end
end

class Computer
  attr_accessor :moves

  def initialize 
    @moves = []
    self.moves << Rock.new
    self.moves << Paper.new
    self.moves << Scissors.new
  end

  def choose
    moves.to_a.shuffle.sample
  end
end

class RPSGame
  attr_accessor :player, :computer

  def initialize
    @player = Player.new
    @computer = Computer.new
  end

  def compare pm, cm
    puts "You picked #{pm} and computer picked #{cm}."
    if pm.to_s == cm.to_s
      puts "It's a tie!"
    elsif pm.beats? cm 
      puts "You won!"
    else
      puts "Computer won!"
    end
  end

  def play
    puts "Play Paper Rock Scissors!"

    begin
      player_move = player.choose
      computer_move = computer.choose

      compare player_move, computer_move
      puts "Play again? (Y/N)"
    end while gets.chomp.downcase == "y"
  end
end

game = RPSGame.new
game.play  
