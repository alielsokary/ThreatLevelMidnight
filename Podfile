# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'ThreatLevelMidnight' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ThreatLevelMidnight
	pod 'Kingfisher', '~> 6.0'
  
	pod 'RxSwift', '6.1.0'
	pod 'RxCocoa', '6.1.0'
	pod 'RxDataSources', '~> 5.0'
  
  pod 'R.swift'
  pod 'SwifterSwift'
  
	pod 'PKHUD'

  target 'ThreatLevelMidnightTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
		installer.pods_project.targets.each do |target|
			target.build_configurations.each do |config|
				config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
			end
		end
end
