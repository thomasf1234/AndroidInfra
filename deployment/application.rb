require 'fileutils'
require 'aecc_client'
require_relative 'app/logger'
require_relative 'lib/log_file'

def ensure_log_directory
  FileUtils.mkdir_p('log')
end

ensure_log_directory
