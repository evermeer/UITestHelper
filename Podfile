source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
workspace 'UITestHelper'

target 'UITestHelperApp' do
  platform :ios, '9.0'
  pod 'UITestHelper/App', :path => "./"
end

target 'UITestHelperUITests' do
    platform :ios, '9.0'
    pod 'UITestHelper', :path => "./"
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if ['UITestHelper'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['ENABLE_BITCODE'] = 'NO'
            end
        end
    end
end
