platform :ios, '11.0'
use_frameworks!

abstract_target 'Abstract' do
 
  pod 'IKEventSource'
  pod 'Marshal', '~> 1.0'

target 'EventSource'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.0'
    end
  end
end