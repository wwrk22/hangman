class WordPicker
  
  def initialize(filename)
    @filename = filename
  end

  def random_word
    file = File::open(@filename, 'r')

    # Get number of lines
    output = `wc -l ./words.txt`.strip!
    num_lines = output.split[0].to_i if output

    # Pick a random line pos
    rand_line_num = Random::rand(num_lines + 1)

    # Go to that line and get the word
    (rand_line_num - 1).times { file.readline }
    word = file.readline.chomp
    puts word
  end

end


wp = WordPicker.new('./words.txt')
wp.random_word
