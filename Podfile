# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'art run' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks! :linkage => :static
  
  # Firebase dependencies
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'Firebase/Analytics', :inhibit_warnings => true # 더 구체적인 모듈 사용 권장

  # Google Maps dependencies
  pod 'GoogleMaps', '~> 7.0', :inhibit_warnings => true
  pod 'GooglePlaces', '~> 7.0', :inhibit_warnings => true

 
 
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
  end

  end
