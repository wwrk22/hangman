require_relative './word_picker'
require 'set'

class Game
  MAX_GUESS = 15

  def initialize(word_file)
    @wp = WordPicker.new(word_file)
  end
  
  def setup_game
    @secret_word = @wp.random_word
    @guess_pool = Set.new
    @guess_count = 0
    @result = "\nYou lose! The word is #{@secret_word}."
  end

  def start
    setup_game
    play_a_round
  end

  def play_a_round
    until @guess_count == MAX_GUESS do
      break if play_a_guess
      @guess_count += 1
    end

    puts @result
  end

  # This method does not account for the number of guesses remaining.
  def play_a_guess
    update_current_word
    display_progress
    guess
    check_guess?
  end

  # Helper
  def check_guess?
    if @current_word == @secret_word
      @result = "\nYou win! The word is #{@secret_word}."
      return true
    end

    return false
  end

  # Helper
  # @current_word must be reset to '' before calling this method.
  def update_current_word
    @current_word = ''
    @secret_word.each_char.reduce(@current_word) do |word, ch|
      @guess_pool.include?(ch) ? (@current_word << ch) : (@current_word << '_')
      @current_word 
    end
  end

  def display_progress
    puts "\n#{@current_word}"
    puts "Letters guessed so far: #{pretty_print_pool}"
    puts "You have #{MAX_GUESS - @guess_count} guesses left."
  end

  def pretty_print_pool
    pretty_print = @guess_pool.reduce('') { |str, letter| str += "#{letter}, " }
    return pretty_print[0..-3] if pretty_print
    return ''
  end

  def guess
    letter = prompt_input until add_to_pool(letter)
    update_current_word
  end

  def prompt_input
    loop do
      print "Guess a letter: "
      letter = gets.chomp
      alphabet?(letter) ? (return letter.downcase) : (puts "Invalid input.")
    end
  end

  def alphabet?(letter) 
    return false if letter == nil || letter.length != 1
    ord = letter.ord
    return (65 <= ord && ord <= 90) || (97 <= ord && ord <= 122)
  end

  def add_to_pool(letter)
    return false if letter == nil

    if @guess_pool.include? letter
      puts "You already guessed '#{letter}'.\n"
      return false
    else
      @guess_pool << letter
      return true
    end
  end
end


g = Game.new('./words.txt')
g.start
