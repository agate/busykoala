class Device
  STORAGE = "#{Rails.root}/tmp/devices.json"

  MAPPING = [
    "BLANK",
    "LAMP",
    "SWITCHER",
    "FAN",
    "TEMPERATURE",
    "SCROLLBAR",
    "BEEPER",
    "PATTERN",
  ]

  BIT_TARGET_INDEXES = [ 1, 6 ]
  VAL_TARGET_INDEXES = [ 3, 7 ]

  def self.all
    JSON.parse(File.read(STORAGE)) rescue []
  end

  def self.find(id)
    all.select{ |device| device["uuid"] == id }.first
  end

  def self.update_all(devices)
    File.write(STORAGE, devices.to_json)
  end
end
