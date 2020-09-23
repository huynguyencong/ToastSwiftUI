#
# Be sure to run `pod lib lint ToastSwiftUI.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = 'ToastSwiftUI'
  s.version          = '0.2'
  s.summary          = 'A simple way to show a toast message in SwiftUI.'
  s.description      = <<-DESC
ToastSwiftUI is a simple open source that will help you to show a toast message in SwiftUI. A toast message is a pop up that show users some information, then quickly close.
                       DESC

  s.homepage         = 'https://github.com/huynguyencong/ToastSwiftUI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Huy Nguyen' => 'conghuy2012@gmail.com' }
  s.source           = { :git => 'https://github.com/huynguyencong/ToastSwiftUI.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/nguyenconghuy91'

  s.ios.deployment_target = '13.0'

  s.source_files = 'ToastSwiftUI/Classes/**/*'

  s.swift_version = '5.0'
end
