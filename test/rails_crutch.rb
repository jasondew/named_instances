require 'active_support'
require 'active_support/cache'

class Rails
  def self.cache
    @@cache ||= ActiveSupport::Cache::MemoryStore.new
  end

  def self.logger
    @@logger ||= ActiveSupport::BufferedLogger.new(STDOUT)
  end
end
