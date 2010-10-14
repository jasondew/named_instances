module NamedInstances

  def self.included base
    base.extend ClassMethods
  end

  module ClassMethods

    def has_named_instances(name_method = :value, options={})
      @named_instances_loaded = false
      @named_instances_name_method = name_method
      @find_options = options[:find_options]

      after_save do
        Rails.logger.info("Reloading #{self.class} named instances because of a save")
        self.class.load_named_instances
      end
    end

    def named_instances_loaded?
      !! @named_instances_loaded
    end

    def name_method
      @named_instances_name_method
    end

    def get *names
      load_named_instances unless @named_instances_loaded

      name = names.map {|n| n.to_s }.join "_"
      key_name = "#{named_instances_prefix}_#{name}"
      result = Rails.cache.read(key_name)

      # gets are hard-coded and should always return something valid from the cache
      raise(ArgumentError, "NamedInstance does not exist: #{key_name}") unless result

      result
    end

    def named_instances_normalize name
      name.downcase.gsub(/[^a-z0-9]+/, '_').gsub(/_$/, '')
    end

    def named_instances_prefix
      "named_instances_#{self}"
    end

    def load_named_instances
      begin
        all(@find_options).each do |instance|
          if (@named_instances_name_method.is_a? String) or (@named_instances_name_method.is_a? Symbol)
            field_name = named_instances_normalize instance.send(@named_instances_name_method)
            key_name = "#{named_instances_prefix}_#{field_name}"
          else
            key_name = @named_instances_name_method.inject(named_instances_prefix) do |key_name, name_method|
              field_name = named_instances_normalize instance.send(name_method)
              key_name + "_#{field_name}"
            end
          end

          Rails.cache.write(key_name, instance)
        end

        @named_instances_loaded = true
      rescue Exception => e
        Rails.logger.info "Named Instances: exception ignored, class = #{self}, error = #{e.inspect}"
      end
    end

  end
end
