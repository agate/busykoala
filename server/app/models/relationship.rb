class Relationship
  STORAGE = "#{Rails.root}/tmp/relationship.json"

  def self.all
    JSON.parse(File.read(STORAGE)) rescue {}
  end

  def self.update(relationships)
    File.write(STORAGE, relationships.to_json)
  end
end
