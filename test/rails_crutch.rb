require "active_support"
require "active_support/cache"
require "active_support/core_ext/logger"

RAILS_CACHE = ActiveSupport::Cache::MemoryStore.new
