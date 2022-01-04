#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'starlight_epub_viewer'

  s.version          = '0.0.1'

  s.summary          = 'A epub reader flutter plugin project.'

  s.description      = <<-DESC
A new flutter plugin project.
                       DESC

  s.homepage         = 'https://github.com/YeMyoAung/starlight_epub_viewer.git'

  s.license          = { :file => '../LICENSE' }

  s.author           = { 'Ye Myo Aung' => 'yemyo994@gmail.com' }

  s.source           = { :path => '.' }

  s.source_files = [
  'Classes/**/*',
  ]

  s.dependency 'Flutter'
  s.dependency 'FolioReaderKit', '~> 1.4.0'
  s.dependency 'Realm', '~> 3.17.3'
  s.ios.deployment_target = '9.0'

  
end
