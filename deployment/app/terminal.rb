class Terminal
  EXIT_STATUS_SUCCESS = 0
  DEFAULT_TIMEOUT_SECONDS = 30*60

  class << self
    def execute(command, timeout=DEFAULT_TIMEOUT_SECONDS)
      formatted_command = command #timeout_cmd(command, timeout)
      return_value = sh(formatted_command)
      exit_status = $?
      raise exit_status.inspect unless exit_status.exitstatus == EXIT_STATUS_SUCCESS
      return_value
    end

    private
    def timeout_cmd(command, duration)
      "timeout #{duration}s #{command}"
    end

    def sh(command)
      `#{command}`
    end
  end
end