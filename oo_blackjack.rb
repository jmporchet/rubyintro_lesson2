require 'pry'
# Game creates Dealer and Player, evaluates hands, allows to continue
# Dealer creates and shuffles deck, hits cards from the deck and stays
# Player hits cards from the deck and stays
# Deck holds cards
# Card

class Game
  def initialize
    dealer = Dealer.new
    
    puts "What's your name?"
    player_one = Human.new gets.chomp

    puts "Number of decks (default: 3)?"
    nr_of_decks = gets.chomp.to_i
    
    decks = []
    decks = Deck.new(nr_of_decks)
    #now merge all decks into one only. flatten! will not work.
    #flat_deck = decks[0].merge(decks[1])
    binding.pry
  end

  def run
  end
end

class Player
  def initialize
  end
end

class Dealer < Player
  def initialize
  end
end

class Human < Player
  attr_accessor :name
  def initialize name
    self.name = name
  end

end

class Deck
  attr_accessor :suits, :values, :deck

  def initialize nr_of_decks = 3
    self.deck = []
    suits = ['D', 'H', 'C','S']
    values = [1,2,3,4,5,6,7,8,9,10,11,12,13]
    nr_of_decks.times do
      suits.each do |suit|
        values.each do |value|
          self.deck << Card.new(suit, value)
        end
      end
    end

    deck
  end
end

class Card
  attr_accessor :face, :value
  def initialize face, value
    self.face = face
    self.value = value
  end
end

game = Game.new