class Device
  STORAGE = "#{Rails.root}/tmp/actions.json"

  def self.all
    JSON.parse(File.read(STORAGE))
  end

  def self.append(action)
    actions = all
    actions << action

    File.write(STORAGE, actions.to_json)
  end
end
