#http://stackoverflow.com/questions/2214377/how-to-get-serial-number-or-id-of-android-emulator-after-it-runs
#http://stackoverflow.com/questions/38910107/simultaneous-running-haxm-avd-emulator-limit
class Device
  ANDROID_TMP_DIR = '/data/local/tmp/'
  attr_reader :avd, :serial_number, :uuid

  def self.allowed_ports
    (5554..5584).step(2).to_a
  end

  def initialize(avd, serial_number, port)
    @avd = avd
    @serial_number = serial_number
    @port = port
  end

  def push(apk, destination=ANDROID_TMP_DIR)
    Terminal.execute("adb -s #{serial_number} push $#{apk.path} #{File.join(destination, apk.package)}")
  end

  def install(apk)
    Terminal.execute("adb -s #{serial_number} shell pm install #{apk.path}")
  end

  def uninstall(package)
    Terminal.execute("adb -s #{serial_number} shell pm uninstall #{package}")
  end

  def force_stop(package)
    Terminal.execute("adb -s #{serial_number} shell am force-stop #{package}")
  end

  def print_alarms
    Terminal.execute("adb -s #{serial_number} shell dumpsys alarm")
  end
end