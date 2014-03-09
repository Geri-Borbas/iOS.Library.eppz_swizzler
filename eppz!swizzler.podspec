#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "eppz!swizzler"
  s.version          = "0.1.0"
  s.summary          = "A short description of Premp."
  s.homepage         = "http://EXAMPLE/NAME"
  s.license          = 'MIT'
  s.author           = { "Borbás Geri, eppz!" => "hello@eppz.eu" }
  s.source           = { :git => "http://EXAMPLE/NAME.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/_eppz'

  # s.platform     = :ios, '5.0'
  # s.ios.deployment_target = '5.0'
  s.requires_arc = true

  s.source_files = 'eppz!swizzler'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'Foundation'
end
