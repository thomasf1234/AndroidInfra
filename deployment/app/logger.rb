require_relative '../lib/log_file'

class Logger
  def initialize
    @log = LogFile.new('deployment')
  end

  def log(msg)
    @log.puts(msg)
  end
end