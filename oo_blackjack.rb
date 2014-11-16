require 'pry'
# Game creates Dealer and Player, evaluates hands, allows to continue
# Dealer creates and shuffles deck, hits cards from the deck and stays
# Player hits cards from the deck and stays
# Deck holds cards
# Card

class Game
  attr_accessor :players, :decks

  THRESHOLD = 21

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

  def who_won
    highest_score = 0
    highest_player = ""
    players.each do |k,v|
      if v.score > highest_score && v.score <= 21
        highest_score = v.score 
        highest_player = v.name 
      elsif v.score == highest_score && v.score <= 21
        highest_score = v.score 
        highest_player = "tie"
      end
    end
    #needs a check to see if it's a tie
    puts highest_player
  end

  def play
    players.each do |k,v|
      v.hit decks
      puts v.hit decks
    end

    while !players[:player_one].has_busted
      puts "1) hit or 2) stay?"
      answer = gets.chomp.to_i
      if answer == 1
        puts players[:player_one].hit decks
        if players[:player_one].has_busted
          puts "You busted!"
          exit
        end
      else 
        break
      end
    end

    while players[:dealer].calculate_hand < 17
      puts players[:dealer].hit decks
    end

    if players[:dealer].has_busted
      puts "dealer busted!"
      exit
    end

    who_won

  end
end

class Player
  attr_accessor :decks, :hand, :has_busted, :score

  def initialize
    self.hand = []
    self.has_busted = false
    self.score = 0
  end

  def hit decks
    self.decks = decks
  end

  def calculate_hand
    amount = 0
    self.hand = hand.sort_by { |k,v| v }
    hand.flatten.each do |card|
      #if the Ace value makes the player bust, transform it to 1 instead
      if (card.value == 11) && ((amount + card.value) > 21)
        card.value = 1
      end
      amount += card.value
    end
    if amount > 21
      self.has_busted = true
    end
    self.score = amount
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
    "Dealer's score: " + self.calculate_hand.to_s
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
    "#{name}'s score: " + self.calculate_hand.to_s
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