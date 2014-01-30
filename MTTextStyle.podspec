Pod::Spec.new do |s|
  s.name         = 'MTTextStyle'
  s.version      = '0.0.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage     = 'https://github.com/mattbocosoft/MTTextStyle'
  s.authors      = { 'Matthew DD Thomas' => 'matt@bocosoft.net' }
  s.summary      = 'Easy application of centralized text styles to text UI element like UILabel, UITextView, UITextField, UIButton and even drawing context.'

# Source Info
  s.platform     =  :ios, '6.0'
  s.source       =  { :git => 'https://github.com/mattbocosoft/MTTextStyle', :tag => s.version.to_s }
  s.source_files = 'MTTextStyle/*.{h,m}'
  s.frameworks    =  'AVFoundation', 'UIKit'

  s.requires_arc = true
  
end
