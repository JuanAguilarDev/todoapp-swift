# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '14.0'

target 'todoapp' do
  
  use_frameworks!
  
  pod 'Alamofire', '~> 5.0'
  pod 'ObjectMapper', '~> 4.2'
  pod 'MaterialComponents'
  pod 'KVNProgress'
  pod 'IQKeyboardManagerSwift'

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
            end
        end
    end
end
