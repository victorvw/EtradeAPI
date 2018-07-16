platform :ios, '11.0'

use_frameworks!
inhibit_all_warnings!

target 'EtradeAPI' do
  pod 'Alamofire'
  pod 'CryptoSwift'
  pod 'Marshal'

  target 'EtradeAPITests' do
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts "#{target.name}"
  end
end
