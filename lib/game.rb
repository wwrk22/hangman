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
end


g = Game.new('./words.txt')
g.start
g.display_progress
