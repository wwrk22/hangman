require_relative './game_data'

class GameDataSaver
  def initialize(game_data)
    @game_data = game_data
  end

  def overwrite_data(new_data)
    @game_data = new_data
  end

  def save_data
    file = File.open(get_filename, 'w')
    file.write @game_data.serialize
    file.close
  end

  def load_data
    file = File.open(get_filename, 'r')
    @game_data.deserialize(file.read)
    file.close
  end


  private

  # Helper
  def get_filename
    "#{@game_data.id}.txt"
  end
end
