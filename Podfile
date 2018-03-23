platform :ios, '11.0'
use_frameworks!

workspace 'Forseti.xcworkspace'

def shared_pods
    pod 'Alamofire'
    pod 'SwiftLint'
end

target 'ForsetiApiKit' do
    project 'Modules/ForsetiApiKit/ForsetiApiKit.xcodeproj'
    shared_pods
end

target 'Forseti' do
    project 'Forseti.xcodeproj'
    pod 'SwiftyBeaver'
    shared_pods
end
