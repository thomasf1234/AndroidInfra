require 'timeout'
require 'socket'

class Port
  LOCALHOST = '127.0.0.1'
  DEFAULT_TIMEOUT = 5

  def initialize(number)
    @number = number
  end

  def free?
    free = false

    begin
      sock = nil

      Timeout::timeout(DEFAULT_TIMEOUT) do
        sock = Socket.new(:INET, :STREAM)
        sockaddr = Socket.sockaddr_in(@number, LOCALHOST)
        if sock.bind(sockaddr)
          free = true
        end
      end
    rescue Errno::EADDRINUSE, Errno::ETIMEDOUT, Timeout::Error
    ensure
      if !sock.nil?
        if !sock.closed?
          sock.close
        end
      end
    end

    return free
  end
end