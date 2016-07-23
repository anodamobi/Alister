#
# Be sure to run `pod lib lint Alister.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Alister'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Alister.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/oks/Alister'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Oksana Kovalchuk' => 'oksana@anoda.mobi' }
  s.source           = { :git => 'https://github.com/oks/Alister.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/oks_ios'
  s.requires_arc     = true

  s.ios.deployment_target = '8.0'

  s.source_files = 'Alister/'
#s.public_header_files = 'Alister/*.h'


s.subspec 'Tasks' do |ss|
    ss.ios.source_files = 'Bolts/Common/*.[hm]'
    ss.ios.public_header_files = 'Bolts/Common/*.h'
  end

  s.subspec 'AppLinks' do |ss|
    ss.ios.deployment_target = '6.0'
    ss.dependency 'Bolts/Tasks'

    ss.ios.source_files = 'Bolts/iOS/**/*.[hm]'
    ss.ios.public_header_files = 'Bolts/iOS/*.h'
  end


end
