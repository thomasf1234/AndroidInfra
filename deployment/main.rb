require_relative "setup"

res = System.instance.terminal.aapt("dump badging deployment/test/samples/apk/test.apk")

apk = Apk.new("deployment/test/samples/apk/test.apk")
emulator = Device.new('Nexus_6_API_24', 'emulator-5554', 5554)
puts apk.inspect
#remote_path = emulator.push(apk)
#emulator.install(remote_path)
emulator.force_stop(apk.package)
emulator.uninstall(apk.package)
puts "exiting"

# log = LogFile.new('System')
# terminal = Terminal.new(log, {'ANDROID_SDK_HOME' => '/Users/tfisher/Library/Android/sdk'})
#
# apk = Apk.new(terminal, "/Users/tfisher/AndroidStudioProjects/ProjectManagement/app/build/outputs/apk/app-debug-androidTest.apk")
#
# puts apk.path
# puts apk.package
# puts apk.launchable_activity
#
#
# emulator = System.new(terminal).start_emulator('Nexus_6_API_23')
# log.close

