require 'singleton'
require 'securerandom'
# require_relative 'device'
require_relative '../../lib/log_file'
require_relative '../terminal'

class System
  include Singleton
  DEFAULT_ANDROID_SDK_HOME = '/usr/lib/android-sdk'
  ANDROID_SERIAL_IDENTIFIER_REGEX = /emulator-\d+/
  DEVICE_BOOTED_IDENTIFIER = '1'

  def initialize
    @terminal = Terminal.new(ENV['ANDROID_SDK_HOME'])
    @logger = Logger.new
  end

  def terminal
    @terminal
  end

  def logger
    @logger
  end

  def copy_to(device, apk, destination='/data/local/tmp/')
    @terminal.adb("push $#{apk.path} #{File.join(destination, apk.package)}")
  end

  def start_emulator(avd)
    device_uuid = SecureRandom.uuid

    @terminal.log.puts("#Starting emulator")
    @terminal.emulator("-no-boot-anim -shell -netdelay none -netspeed full -prop emu.uuid=#{device_uuid} -avd #{avd} > #{avd}.log &")

    @terminal.log.puts("#finding serial number for uuid '#{device_uuid}'")
    android_serial = retry_block(5, 10) do
      android_serials = @terminal.adb("devices").scan(ANDROID_SERIAL_IDENTIFIER_REGEX)

      if(android_serials.empty?)
        @terminal.log.puts("raising: No device not found")
        raise 'No device not found'
      else
        android_serial = android_serials.detect do |android_serial|
          arbitrary_device_uuid = @terminal.adb("-s #{android_serial} shell getprop emu.uuid")
          arbitrary_device_uuid == device_uuid
        end

        if android_serial.nil?
          @terminal.log.puts("raising: Device with uuid '#{device_uuid}' not found")
          raise "Device with uuid '#{device_uuid}' not found"
        else
          android_serial
        end
      end
    end

    require 'pry'; binding.pry


    device_booted = false
    until (device_booted)
      device_booted = @terminal.adb("-s #{android_serial} shell getprop sys.boot_completed").include?(DEVICE_BOOTED_IDENTIFIER)
      wait(1)
    end

    Device.new(avd, android_serial, device_uuid)
  end

  private
  def wait(seconds)
    sleep(seconds)
  end


  def retry_block(count, rest_interval)
    retry_count = 0

    while retry_count < count do
      begin
        result = yield
        break
      rescue => e
        retry_count += 1
        result = e
        wait(rest_interval)
      end
    end

    if result.kind_of?(Exception)
      raise result
    else
      result
    end
  end
end