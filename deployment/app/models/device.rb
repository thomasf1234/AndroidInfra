require_relative 'port'
#http://stackoverflow.com/questions/2214377/how-to-get-serial-number-or-id-of-android-emulator-after-it-runs
#http://stackoverflow.com/questions/38910107/simultaneous-running-haxm-avd-emulator-limit
class Device
  ANDROID_TMP_DIR = '/data/local/tmp/'
  attr_reader :avd_name, :serial_number, :uuid

  def self.allowed_ports
    (5554..5584).step(2).to_a
  end

  def initialize(avd_name, serial_number, port)
    @avd_name = avd_name
    @serial_number = serial_number
    @port = port
  end

  def push(apk, destination=ANDROID_TMP_DIR)
    remote_path = File.join(destination, apk.package)
    System.instance.terminal.adb("-s #{serial_number} push #{apk.path} #{remote_path}")

    return remote_path
  end

  def install(remote_path)
    System.instance.terminal.adb("-s #{serial_number} shell pm install #{remote_path}")
  end

  def uninstall(package)
    System.instance.terminal.adb("-s #{serial_number} shell pm uninstall #{package}")
  end

  def force_stop(package)
    System.instance.terminal.adb("-s #{serial_number} shell am force-stop #{package}")
  end

  def print_alarms
    System.instance.terminal.adb("-s #{serial_number} shell dumpsys alarm")
  end
end