Pod::Spec.new do |s|
  s.name         = "UITestHelper"
  s.version      = "0.3.0"
  s.summary      = "UI test helper functions"

  s.description  = <<-EOS
UI test helper function for keeping your test code clean.
EOS

  s.homepage     = "https://github.com/evermeer/UITestHelper"
  s.license      = { :type => "MIT", :file => "License" }
  s.author             = { "Edwin Vermeer" => "edwin@evict.nl" }
  s.social_media_url   = "http://twitter.com/evermeer"

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.source       = { :git => "https://github.com/evermeer/UITestHelper.git", :tag => s.version }
  s.default_subspec = "Core"

# This is the core UITestHelper library
  s.subspec "Core" do |ss|
    ss.ios.deployment_target = '9.0'
    ss.source_files  = "Source/*.swift"
    ss.framework  = "XCTest"
  end

# This is the core UITestHelper library
  s.subspec "App" do |ss|
    ss.ios.deployment_target = '8.0'
    ss.source_files  = "Source/App/*.swift"
  end

end
