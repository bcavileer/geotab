require "faraday"
require "multi_json"
require "geotab/version"
require "geotab/concerns"
require "geotab/concerns/conditionable"
require "geotab/concerns/connectable"
require "geotab/concerns/findable"
require "geotab/concerns/initializable"
require "geotab/client"
require "geotab/device"
require "geotab/device_status_info"
require "geotab/diagnostic"
require "geotab/failure_mode"
require "geotab/fault_datum"
require "geotab/log_record"
require "geotab/status_datum"
require "geotab/exceptions"
require "hash"

module Geotab
  def self.config
    yield self
  end

  def self.with_connection(connection)
    @connection_block = connection
    yield
    @connection_block = nil
  end

  def self.has_config?
    @username && @password && @path
  end

  def self.username
    @username
  end

  def self.username=(value)
    @username = value
  end

  def self.password
    @password
  end

  def self.password=(value)
    @password = value
  end

  def self.database
    @database
  end

  def self.database=(value)
    @database = value
  end

  def self.path
    @path
  end

  def self.path=(value)
    @path = value
  end

  def self.connection_block
    @connection_block
  end
end
