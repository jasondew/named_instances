module NamedInstances

  class Railtie < Rails::Railtie
    initializer "named_instances.initialize" do |app|
      ActiveRecord::Base.send :include, NamedInstances if defined?(ActiveRecord)
    end
  end

end
