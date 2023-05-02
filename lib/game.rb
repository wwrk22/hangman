require_relative './word_picker'
require 'set'

class Game
  MAX_GUESS = 15

  def initialize(word_file)
    @wp = WordPicker.new(word_file)
  end
  
  def start
    @word = @wp.random_word
    @guess_pool = Set.new
    @guess_count = 0
  end

  def play_guess
    display_progress
    guess
  end

  def display_progress
    @word.each_char { |ch| @guess_pool.include?(ch) ? (print ch) : (print '_') }
    puts
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
    @guess_count += 1
  end

  def prompt_input
    loop do
      print "Guess a letter: "
      letter = gets.chomp
      alphabet?(letter) ? (return letter) : (puts "Invalid input.")
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
      puts "You already guessed '#{letter}'."
      return false
    else
      @guess_pool << letter
      return true
    end
  end
end


g = Game.new('./words.txt')
g.start
g.play_guess
g.play_guess
g.play_guess
