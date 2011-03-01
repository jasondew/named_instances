module NamedInstances

  def self.included base
    base.extend ClassMethods
  end

  module ClassMethods

    module InstanceMethods
      def normalized_name
        self.class.named_instances_normalize send(self.class.name_method)
      end
    end

    def has_named_instances(name_method = :value)
      @named_instances_loaded = false
      @named_instances_name_method = name_method

      after_save {|model| model.class.load_named_instances }
      include InstanceMethods
    end

    def named_instances_loaded?
      !! @named_instances_loaded
    end

    def name_method
      @named_instances_name_method
    end

    def get name_or_names
      load_named_instances unless @named_instances_loaded

      if not name_or_names.is_a?(String) and name_or_names.respond_to? :map
        name_or_names.map {|name| get_one name }
      else
        get_one name_or_names
      end
    end

    def get_one name
      return if name.blank?
      key_name = "#{named_instances_prefix}_#{name}"

      begin
        Rails.cache.read key_name
      rescue
        load_named_instances
        Rails.cache.read key_name
      end
    end

    def named_instances_normalize name
      name.downcase.gsub(/[',]/, '').gsub(/[^a-z0-9_]+/, '_').gsub(/_$/, '')
    end

    def named_instances_prefix
      "named_instances_#{self}"
    end

    def load_named_instances
      begin
        all.each do |instance|
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
