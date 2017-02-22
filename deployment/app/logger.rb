require 'singleton'
require_relative '../lib/log_file'

module AndroidDeployment
  class Logger
    include Singleton

    def initialize
      @log = LogFile.new('deployment')
      ObjectSpace.define_finalizer(self,
                                   self.class.method(:finalize).to_proc)
    end

    def Logger.finalize(id)
      instance.close_log
      puts "AndroidDeployment::Logger closing log"
    end

    def log(msg)
      @log.puts(msg)
    end

    def close_log
      @log.close
    end
  end
end
