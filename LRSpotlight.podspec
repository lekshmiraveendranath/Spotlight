Pod::Spec.new do |s|
  s.name            = "LRSpotlight"
  s.version         = "1.6.0"
  s.swift_version   = "4.2.0"
  s.license         = { :type => 'MIT', :file => "License.md" }
  s.summary         = "Introductory Walkthrough framework for iOS Apps"
  s.description     = "Spotlight makes it a piece of cake to display introductory walkthrough tutorials for iOS apps"
  s.homepage        = "https://github.com/lekshmiraveendranath/Spotlight"
  s.author          = { "Lekshmi Raveendranathapanicker" => "lekshmi.ravindranath@gmail.com" }
  s.source          = { :git => "https://github.com/lekshmiraveendranath/Spotlight.git", :tag => s.version }
  s.source_files    = "Spotlight/Sources"
  s.resources       = "Spotlight/Sources/*.xcassets"
  s.framework       = "Foundation"
  s.ios.framework   = "UIKit"
  s.ios.deployment_target = '9.0'
end
