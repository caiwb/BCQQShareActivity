#
# Be sure to run `pod lib lint BCQQShareActivity.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BCQQShareActivity'
  s.version          = '0.1.0'
  s.summary          = 'A short description of BCQQShareActivity.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/<GITHUB_USERNAME>/BCQQShareActivity'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'caiwenbo' => 'caiwenbo@rd.netease.com' }
  s.source           = { :git => 'https://github.com/<GITHUB_USERNAME>/BCQQShareActivity.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'BCQQShareActivity/Classes/*.{h,m}'
  s.resource = 'BCQQShareActivity/Assets/**/*'

  s.private_header_files = 'BCQQShareActivity/Classes/**/*.h'

  s.frameworks = 'SystemConfiguration', 'CoreGraphics', 'CoreTelephony'
  s.vendored_frameworks = 'TencentActivity/Classes/TencentOpenAPI.framework'
  s.libraries = 'iconv', 'sqlite3', 'z', 'c++'

  # s.resource_bundles = {
  #   'BCQQShareActivity' => ['BCQQShareActivity/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
