require_relative './json_serializable'

class GameData
  include JsonSerializable

  attr_accessor :id, :secret_word, :guess_count, :guess_pool

  def initialize(id, secret_word, guess_count, guess_pool)
    @id = id
    @secret_word = secret_word
    @guess_count = guess_count
    @guess_pool = guess_pool
  end
end
