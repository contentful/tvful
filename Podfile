platform :tvos, '9.0'
use_frameworks!

target 'tvful' do

pod 'ContentfulDeliveryAPI', :git => 'https://github.com/contentful/contentful.objc.git', :branch => 'tvos'
#pod 'ContentfulDeliveryAPI', :path => '../../Projects/contentful.objc'

pod 'AFNetworking', :git => 'https://github.com/neonichu/AFNetworking.git', :branch => 'tvos'
#pod 'AFNetworking', :path => '../../Sources/AFNetworking'

pod 'ISO8601DateFormatter', :podspec => 'vendor/ISO8601DateFormatter.podspec.json', :inhibit_warnings => true

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'YES'
    end
  end
end
