require 'singleton'
require 'securerandom'
require_relative 'device'
require_relative '../../lib/log_file'
require_relative '../terminal'

class System
  include Singleton
  DEFAULT_ANDROID_SDK_HOME = '/usr/lib/android-sdk'
  ANDROID_SERIAL_IDENTIFIER_REGEX = /emulator-\d+/
  DEVICE_BOOTED_IDENTIFIER = '1'

  def initialize
    @terminal = Terminal.new
  end

  def terminal
    @terminal
  end

  def deploy(apk, device)
    remote_path = device.push(apk)
    device.install(remote_path)
  end

  def start_emulator(avd_name)
    Logger.instance.log("#Starting emulator")
    port = Device.allowed_ports.detect(&:free?)

    if port.nil?
      raise "No free ports available"
    else
      terminal.emulator("-no-boot-anim -shell -netdelay none -netspeed full -port #{port.number} -avd #{avd_name} > #{avd_name}.log &")

      Logger.instance.log("#waiting for device to boot")
      android_serial = retry_block(5, 10) do
        android_serials = @terminal.adb("devices").scan(ANDROID_SERIAL_IDENTIFIER_REGEX)

        if(android_serials.empty?)
          @terminal.log.puts("raising: No device not found")
          raise 'No device not found'
        else
          android_serial = android_serials.detect do |android_serial|
            !android_serial.match(/#{port.number}/).nil?
          end

          if android_serial.nil?
            Logger.instance.log("raising: Device with port '#{port.number}' not found")
            raise "Device with port '#{port.number}' not found"
          else
            android_serial
          end
        end
      end
    end

    device_booted = false
    until (device_booted)
      device_booted = terminal.adb("-s #{android_serial} shell getprop sys.boot_completed").include?(DEVICE_BOOTED_IDENTIFIER)
      wait(1)
    end

    Device.new(avd_name, android_serial, port)
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