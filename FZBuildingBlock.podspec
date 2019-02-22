#
# Be sure to run `pod lib lint FZBuildingBlock.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'FZBuildingBlock'
    s.version          = '0.1.0'
    s.summary          = '提供开发中最基础的功能组件'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/FranZhou/FZBuildingBlock'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'FranZhou' => 'fairytale_zf@outlook.com' }
    s.source           = { :git => 'https://github.com/FranZhou/FZBuildingBlock.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '8.0'
    
    #  s.source_files = 'FZBuildingBlock/Classes/**/*'
    
    s.swift_version = '4.2'
    
    s.subspec 'Extension' do |s_extension|
        s_extension.source_files = 'FZBuildingBlock/Extension/Classes/**/*'
        s_extension.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'
#        s_extension.resource_bundles = {
#            'FZBuildingBlock_Extension' => ['FZBuildingBlock/Extension/Assets/**/*']
#        }
    end
    
    s.subspec 'Observer' do |s_observer|
        s_observer.source_files = 'FZBuildingBlock/Observer/Classes/**/*'
        s_observer.frameworks = 'Foundation'
    end
    
    s.subspec 'KeyChain' do |s_keychain|
        s_keychain.source_files = 'FZBuildingBlock/KeyChain/Classes/**/*'
        s_keychain.frameworks = 'Foundation'
    end
    
    s.subspec 'KeyboardObserver' do |s_keyboard|
        s_keyboard.source_files = 'FZBuildingBlock/KeyboardObserver/Classes/**/*'
        s_keyboard.frameworks = 'UIKit', 'Foundation'
    end
    
    
    # s.resource_bundles = {
    #   'FZBuildingBlock' => ['FZBuildingBlock/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
