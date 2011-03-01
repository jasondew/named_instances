require "rails"
require "active_support"
require "active_support/cache"

def Rails.cache
  @cache ||= ActiveSupport::Cache::MemoryStore.new
end

def Rails.logger
  @logger ||= Logger.new(STDOUT)
end
