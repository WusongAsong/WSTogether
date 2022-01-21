#
# Be sure to run `pod lib lint Together.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Together'
  s.version          = '1.0.0'
  s.summary          = '自定义'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/wusong560/Together'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WusongAsong' => '13817407397@163.com' }
  s.source           = { :git => 'https://github.com/WusongAsong/WSTogether.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Together/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Together' => ['Together/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'AFNetworking'
   
end
