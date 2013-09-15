class Action
  STORAGE = "#{Rails.root}/tmp/actions.json"

  def self.all
    JSON.parse(File.read(STORAGE)) rescue []
  end

  def self.append(action)
    actions = all
    actions << action

    File.write(STORAGE, actions.to_json)
  end

  def self.clear!
    File.write(STORAGE, '[]')
  end
end
