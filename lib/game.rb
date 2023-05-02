require_relative './word_picker'
require 'set'

class Game
  def initialize(word_file)
    @wp = WordPicker.new(word_file)
  end
  
  def start
    @word = @wp.random_word
    @guess_pool = Set.new
    @guess_count = 0
  end

  def display_progress
    @word.each_char { |ch| @guess_pool.include?(ch) ? (print ch) : (print '_') }
    puts
  end

  def guess
    letter = gets.chomp
    letter_added = add_to_pool(letter) if alphabet?(letter)
  end

  def alphabet?(letter)
    return false if letter.length != 1
    ord = letter.ord
    return (65 <= ord && ord <= 90) || (97 <= ord && ord <= 122)
  end

  def add_to_pool(letter)
    return false if @guess_pool.include? letter
    @guess_pool << letter
    return true
  end
end


g = Game.new('./words.txt')
g.start
g.display_progress
g.guess
g.guess
