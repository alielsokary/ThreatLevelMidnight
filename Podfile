# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'ThreatLevelMidnight' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ThreatLevelMidnight
	pod 'Alamofire', '~> 5.2'
	pod 'AlamofireNetworkActivityLogger', '~> 3.4'
	pod 'Kingfisher', '~> 6.0'
  
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'RxDataSources', '~> 4.0'
  
  pod 'R.swift'
  pod 'SwifterSwift'
  
  pod 'NVActivityIndicatorView'

  target 'ThreatLevelMidnightTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ThreatLevelMidnightUITests' do
    # Pods for testing
  end

end

plugin 'cocoapods-keys', {
:project => "ThreatLevelMidnight",
:keys => [
	"TMDB_AccessToken"
]}

post_install do |installer|
		installer.pods_project.targets.each do |target|
			target.build_configurations.each do |config|
				config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
			end
		end
end
