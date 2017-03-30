Pod::Spec.new do |s|

  s.name         = "BussinessTwoDylib"
  s.version  = "1.0.0"
  s.summary      = "A short description of BussinessTwoDylib."

  s.description  = <<-DESC
                   业务模块二的动态库
                   DESC

  s.homepage     = "http://EXAMPLE/Prophet"
  s.license      = "MIT (example)"
  s.author       = { "寻峰" => "qisheng.lqs@alibaba-inc.com" }

  s.platform     = :ios, "7.0"
  s.requires_arc = true
  s.source_files = "*.{h,m,mm}"
  s.dependency "HHRouter"
  s.xcconfig = {
          'CLANG_CXX_LANGUAGE_STANDARD' => 'compiler-default',
          'CLANG_CXX_LIBRARY' => 'compiler-default',
          'GCC_C_LANGUAGE_STANDARD' => 'compiler-default'
          }


end
