class Device
  STORAGE = "#{Rails.root}/tmp/devices.json"

  def self.all
    JSON.parse(File.read(STORAGE))
  end

  def self.find(id)
    all.select{ |device| device["uuid"] == id }.first
  end

  def self.update_all(devices)
    File.write(STORAGE, devices.to_json)
  end
end
