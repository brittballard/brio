load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

# gems and gem recipes
[
  # capistrano-ext
  ["capistrano/ext/monitor", "capistrano/ext/multistage"],
].each do |gems|
  begin
    [*gems].each {|g| require g }
  rescue LoadError => e
    logger.important e.message
  end
end

# custom recipes
Dir["lib/recipes/*.rb"].each { |recipe| load(recipe) }
load 'config/deploy' # remove this line to skip loading any of the default tasks