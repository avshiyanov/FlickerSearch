source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

workspace 'FlickFinder.xcworkspace'
xcodeproj 'FlickFinder.xcodeproj'

def shared_pods
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxAlamofire'
end

target 'flickFinder' do
    shared_pods
    pod 'Alamofire'
    pod 'AlamofireImage'
    pod 'SwiftyJSON'
end

target 'flickFinderTests' do
    shared_pods
    pod 'Alamofire'
    pod 'AlamofireImage'
    pod 'SwiftyJSON'
end

target 'flickFinderUITests' do
    shared_pods
    pod 'Alamofire'
    pod 'AlamofireImage'
    pod 'SwiftyJSON'
end
