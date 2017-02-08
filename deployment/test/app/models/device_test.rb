require 'test/unit'
require_relative '../../../../deployment/app/models/apk'

class ApkTest < Test::Unit::TestCase
  def test_apk
    apk = Apk.new("deployment/test/samples/apk/test.apk")

    assert_equal(File.expand_path("deployment/test/samples/apk/test.apk"), apk.full_path)
    assert_equal("deployment/test/samples/apk/test.apk", apk.path)
    assert_equal("com.example.ad.testapp2", apk.package)
    assert_equal("com.example.ad.testapp2.MainActivity", apk.launchable_activity)
  end
end