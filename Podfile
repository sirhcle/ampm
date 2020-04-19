# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'AMPM' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AMPM
  pod 'RAMAnimatedTabBarController'
  pod 'Eureka'
  pod 'Firebase/Analytics'
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'
  pod 'Loaf'
  pod 'CFAlertViewController'
  pod "KRProgressHUD"
  pod "RealmSwift"
  pod 'JitsiMeetSDK'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['ENABLE_BITCODE'] = 'NO'
      end
    end
  end
end
