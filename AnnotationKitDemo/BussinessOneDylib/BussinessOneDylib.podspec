Pod::Spec.new do |s|

  s.name         = "BussinessOneDylib"
  s.version  = "1.0.0"
  s.summary      = "A short description of BussinessOneDylib."

  s.description  = <<-DESC
                   业务模块一的动态库
                   DESC

  s.homepage     = "http://EXAMPLE/AnnotationKit"
  s.license      = "MIT (example)"
  s.author       = { "luoqisheng" => "540025011@qq.com" }

  s.platform     = :ios, "7.0"
  s.requires_arc = true
  s.source_files = "*.{h,m,mm}"
  s.dependency "AnnotationKit"
  s.xcconfig = {
          'CLANG_CXX_LANGUAGE_STANDARD' => 'compiler-default',
          'CLANG_CXX_LIBRARY' => 'compiler-default',
          'GCC_C_LANGUAGE_STANDARD' => 'compiler-default'
          }


end
