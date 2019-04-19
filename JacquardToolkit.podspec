Pod::Spec.new do |s|

  s.name          = "JacquardToolkit"
  s.version       = "1.1.3"
  s.summary       = "This development toolkit for the Levi's Jacquard."
  s.description   = "This is a framework for interacting with the Levi's Jacquard made by Caleb Rudnicki"
  s.homepage      = "https://github.com/calebrudnicki/JacquardToolkit"
  s.license       = "MIT"
  s.author        = { "Caleb Rudnicki" => "calebrudnicki@gmail.com" }
  s.platform      = :ios, "11.0"
  s.source        = { :git => "https://github.com/calebrudnicki/JacquardToolkit.git", :tag => s.version.to_s }
  s.source_files  = "JacquardToolkit/**/*.{h,m,swift,mlmodel}"
  s.exclude_files = [ 'JacquardToolkit/CustomGestureModels/**']
  

end
