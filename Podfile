platform :ios, '9.0'

abstract_target 'App' do
  use_frameworks!
  pod 'Core', :path => 'core-ios'
  pod 'Crashlytics', '~> 3.7'
  pod 'Fabric', '~> 1.6'
  pod 'Instabug', '~> 5.3'
  pod 'Reveal-iOS-SDK', :configurations => ['Debug']
  pod 'RxCocoa', '~> 2.6'

  target 'beta'
  target 'release'
end
