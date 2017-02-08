require 'singleton'
require_relative 'logger'

class Terminal
  EXIT_STATUS_SUCCESS = 0
  DEFAULT_TIMEOUT_SECONDS = 30*60

  def initialize(android_sdk_home, stubbed=false)
    @android_sdk_home = android_sdk_home
    @stubbed = stubbed
  end

  def stubbed?
    @stubbed
  end

  def get_last_command
    @last_command
  end

  def execute(command, timeout=DEFAULT_TIMEOUT_SECONDS)
    Logger.instance.log("executing: '#{command}'")
    formatted_command = timeout_cmd(command, timeout)
    return_value = sh(formatted_command)
    exit_status = $?
    raise exit_status.inspect unless exit_status.exitstatus == EXIT_STATUS_SUCCESS
    return_value
  end

  def adb(command)
    execute("#{File.join(@android_sdk_home, 'platform-tools/adb')} #{command}")
  end

  def emulator(command)
    execute("#{File.join(@android_sdk_home, 'tools/emulator')} #{command}")
  end

  private
  def timeout_cmd(command, duration)
    command
    # "timeout #{duration}s #{command}"
  end

  def sh(command)
    @last_command = command

    if !stubbed?
      `#{command}`
    end
  end
end