module Chimpdoc

  def self.config
    @config ||= Chimpdoc::Config.new
    yield @config if block_given?
    @config
  end

  class Config
    attr_accessor :cache, :storage_type

    def storage(type=nil)
      @storage_type = type unless type.nil?
      @storage ||= StorageConfig.new
      yield @storage if block_given?
      @storage
    end
  end

  class StorageConfig < Struct.new(:app, :token, :directory); end

end