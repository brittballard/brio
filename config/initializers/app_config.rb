module AppConfig
  def self.[](*args)
    args.inject(CONFIG) { |hash, arg| hash[arg] }
  end
  
  def self.method_missing(method, *args)
    self[method, *args]
  end
  
  yaml = YAML.load(ERB.new(File.read(Rails.root.join('config', 'app.yml'))).result)
  CONFIG = HashWithIndifferentAccess.new(yaml[Rails.env]).freeze
end