require_relative './game_data'

class GameDataSaver
  attr_reader :game_data

  def initialize(game_data=GameData.new(0, '', 0, []))
    @game_data = game_data
  end

  def update_data(new_data)
    @game_data = new_data
  end

  def update_id(new_id)
    @game_data.id = new_id
  end

  def save_data
    file = File.open(get_filepath, 'w')
    file.write @game_data.serialize
    file.close
  end

  def load_data
    file = File.open(get_filepath, 'r')
    @game_data.deserialize(file.read)
    file.close
  end


  private

  # Helper
  def get_filepath
    "./saved_games/#{@game_data.id}.txt"
  end
end
