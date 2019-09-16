#
# Be sure to run `pod lib lint FZBuildingBlock.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'FZBuildingBlock'
    s.version          = '0.2.0'
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
    
    s.swift_version = '5.0'
    
    # for using OpenSSL-Universal
    s.static_framework = true
    
    # 扩展
    s.subspec 'Extensions' do |s_extensions|
        s_extensions.source_files = 'FZBuildingBlock/Extensions/Classes/**/*'
        s_extensions.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'
#        s_extensions.resource_bundles = {
#            'FZBuildingBlock_Extension' => ['FZBuildingBlock/Extension/Assets/**/*']
#        }
    end
    
    # 观察者
    s.subspec 'Observer' do |s_observer|
        s_observer.source_files = 'FZBuildingBlock/Observer/Classes/**/*'
        s_observer.frameworks = 'Foundation'
    end
    
    # 工具目录
    s.subspec 'Tools' do |s_tools|
        s_tools.source_files = 'FZBuildingBlock/Tools/Classes/**/*'
        s_tools.frameworks = 'UIKit', 'Foundation'
        
        s_tools.resources = 'FZBuildingBlock/Tools/Resources/**/*'
        s_tools.preserve_path = 'FZBuildingBlock/Tools/Resources/Tools.modulemap'
        s_tools.xcconfig = { 'SWIFT_INCLUDE_PATHS' => '$(PODS_ROOT)/FZBuildingBlock/Tools/Resources'}
    end
    
    # 自定义视图
    s.subspec 'Views' do |s_views|
        s_views.source_files = 'FZBuildingBlock/Views/Classes/**/*'
        s_views.frameworks = 'UIKit'
        s_views.dependency 'FZBuildingBlock/Extensions'
    end
    
    # 自定义路由
    s.subspec 'Router' do |s_router|
        s_router.source_files = 'FZBuildingBlock/Router/Classes/**/*'
        s_router.frameworks = 'Foundation'
    end
    
    # s.resource_bundles = {
    #   'FZBuildingBlock' => ['FZBuildingBlock/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
