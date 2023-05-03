require 'json'

module JsonSerializable
  def serialize
    data = {}
    instance_variables.map do |key|
      data[key] = instance_variable_get(key)
    end 
    JSON.dump data
  end

  def deserialize(json_str)
    data = JSON.parse(json_str)
    data.keys.each do |key|
      instance_variable_set(key, data[key])
    end
  end
end
