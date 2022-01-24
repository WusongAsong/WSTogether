Pod::Spec.new do |s|
  s.name             = 'WSTogether'
  s.version          = '3.0.0'
  s.summary          = '自定义'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/WusongAsong/WSTogether.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WusongAsong' => '13817407397@163.com' }
  s.source           = { :git => 'https://github.com/WusongAsong/WSTogether.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'WSTogether/Classes/**/*.{h}'
  s.frameworks = 'UIKit'
  s.dependency 'AFNetworking'
   
end
