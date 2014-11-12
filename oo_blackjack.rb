require 'pry'
# Game creates Dealer and Player, evaluates hands, allows to continue
# Dealer creates and shuffles deck, hits cards from the deck and stays
# Player hits cards from the deck and stays
# Deck holds cards
# Card

class Game
  attr_accessor :players, :decks

  def initialize
    self.players = {}
    puts "What's your name?"
    self.players[:player_one] = Human.new gets.chomp


    self.players[:dealer] = Dealer.new

    puts "Number of decks (default: 3)?"
    nr = gets.chomp.to_i
    nr_of_decks = nr == 0 ? 3 : nr
    
    self.decks = []
    self.decks = Deck.new(nr_of_decks)
    #now merge all decks into one only. flatten! will not work.
    #flat_deck = decks[0].merge(decks[1])
  end

  def play
    players.each do |k,v|
      v.hit decks
      v.hit decks
    end

    while players[:dealer].calculate_hand < 17
      players[:dealer].hit decks
      puts "dealer hits one more time! " + players[:dealer].calculate_hand.to_s
    end

    players.each do |k,v|
      puts "#{v.name} has " + v.calculate_hand.to_s
    end

    if players[:dealer].calculate_hand > 21
      puts "dealer busted!"
      exit
    end

  end
end

class Player
  attr_accessor :decks, :hand

  def initialize
    self.hand = []
  end

  def hit decks
    self.decks = decks
  end

  def calculate_hand
    amount = 0
    self.hand = hand.sort_by { |k,v| v }
    hand.flatten.each do |card|
      if (card.value == 11) && ((amount + card.value) > 21)
        card.value = 1
        puts "Ace transformed to 1"
      end
      amount += card.value
    end
    amount
  end
end

class Dealer < Player
  attr_accessor :name

  def initialize
    self.hand = []
    self.name = "dealer"
  end

  def hit decks
    self.hand << decks.deck.sample(1)
  end
end

class Human < Player
  attr_accessor :name

  def initialize name
    self.hand = []
    self.name = name
  end

  def hit decks
    self.hand << decks.deck.sample(1)
  end
end

class Deck
  attr_accessor :suits, :values, :deck

  def initialize nr_of_decks = 3
    self.deck = []
    suits = ['D', 'H', 'C','S']
    values = [11,2,3,4,5,6,7,8,9,10,10,10,10]
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

game = Game.new.play