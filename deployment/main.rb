require_relative "setup"

apk = Apk.new("/Users/tfisher/AndroidStudioProjects/ProjectManagement/app/build/outputs/apk/app-debug-androidTest.apk")


puts apk.path
puts apk.package
puts apk.launchable_activity