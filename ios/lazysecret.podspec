#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint lazysecret.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'lazysecret'
  s.version          = '1.0.0'
  s.summary          = 'Lazysecret is a comprehensive Flutter implementation of the libsodium secret_box library.'
  s.description      = <<-DESC
Lazysecret is a comprehensive Flutter implementation of the libsodium secret_box library.
                       DESC
  s.homepage         = 'https://github.com/prongbang/lazysecret'
  s.license          = { :file => '../LICENSE' }
  s.author           = 'prongbang'
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency       'Flutter'
  s.dependency       'Sodium', '~> 0.9.1'
  s.platform         = :ios, '12.0'
  s.swift_version    = ["4.0", "4.1", "4.2", "5.0", "5.1", "5.2", "5.3", "5.4", "5.5"]

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
