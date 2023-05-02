class WordPicker
  
  def initialize(filename)
    @filename = filename
  end

  # Pick a word at random from the current file.
  def random_word
    file = File::open(@filename, 'r')
    (random_line_num - 1).times { file.readline }
    word = file.readline.chomp
    file.close # Don't let the fd live for the life of the program
    return word
  end


  private

  def random_line_num
    output = `wc -l ./words.txt`.strip
    num_lines = output.split[0].to_i if output
    return Random::rand(num_lines + 1) 
  end

end
