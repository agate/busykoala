class Busykoala::Config
  class << self
    def method_missing(method, *args)
      if env_config.respond_to?(method)
        return env_config.send(method)
      else
        return nil
      end
    end
  end
end
