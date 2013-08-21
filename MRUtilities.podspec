Pod::Spec.new do |s|
  s.name         = "MRUtilities"
  s.version      = "1.0.0"
  s.summary      = "iOS utility library"
  s.homepage     = "https://github.com/martinrybak/MRUtilities"
  s.license      = { :type => 'BSD' }
  s.author       = { "Martin Rybak" => "martin.rybak@gmail.com" }
  s.source       = { :git => "https://github.com/martinrybak/MRUtilities", :tag => "1.0.0" }
  s.platform     = :ios, '6.0'
  s.source_files = 'Utilities/*.{h,m}'
  s.requires_arc = true
end
