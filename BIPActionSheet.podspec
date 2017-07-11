Pod::Spec.new do |s|
  s.name             = "BIPActionSheet"
  s.version          = '1.0.1'
  s.summary          = "Custom ActionSheet replacement with image support"
  s.description      = <<-DESC
  Custom ActionSheet with image and text support, which is easy to use and modify. We developed to use in our BIP Messenger Application
                       DESC
  s.homepage         = "https://github.com/Turkcell/BIPActionSheet"
  s.license          = 'MIT'
  s.author           = { "Ahmet Kazım Günay" => "ahmetkgunay@gmail.com" }
  s.source           = { :git => "https://github.com/Turkcell/BIPActionSheet.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ahmtgny'
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Source/*.{h,m}'
end
