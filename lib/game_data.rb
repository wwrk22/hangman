class GameData
  attr_accessor :secret_word, :guess_count, :guess_pool

  def initialize(secret_word, guess_count, guess_pool)
    @secret_word = secret_word
    @guess_count = guess_count
    @guess_pool = guess_pool
  end
end
