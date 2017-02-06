class Device
  attr_reader :name

  def install(apk)
    Terminal.execute("adb shell pm install #{apk.path}")
  end

  def uninstall(package)
    Terminal.execute("adb shell pm uninstall #{package}")
  end
end