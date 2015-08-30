Pod::Spec.new do |s|
  s.name              = "Operations"
  s.version           = "0.10.1"
  s.summary           = "Powerful NSOperation subclasses in Swift."
  s.description       = <<-DESC
  
A Swift 1.2 framework inspired by Apple's WWDC 2015
session Advanced NSOperations: https://developer.apple.com/videos/wwdc/2015/?id=226

                       DESC
  s.homepage          = "https://github.com/danthorpe/Operations"
  s.license           = 'MIT'
  s.author            = { "Daniel Thorpe" => "@danthorpe" }
  s.source            = { :git => "https://github.com/danthorpe/Operations.git", :tag => s.version.to_s }
  s.social_media_url  = 'https://twitter.com/danthorpe'
  s.requires_arc      = true
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.source_files      = 'Operations/**/*.{swift,m,h}'
  s.osx.exclude_files = "Operations/**/*{RemoteNotification,UserConfirmation,AddressBook,LocationCondition,BackgroundObserver,NetworkObserver,AlertOperation,LocationOperation}*"

end

