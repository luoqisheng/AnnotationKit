Pod::Spec.new do |s|

  s.name         = "BussinessTwoDylib"
  s.version  = "1.0.0"
  s.summary      = "A short description of BussinessTwoDylib."

  s.description  = <<-DESC
                   业务模块二的动态库
                   DESC

  s.homepage     = "https://github.com/luoqisheng/AnnotationKit"
  s.license      = "MIT"
  s.author       = { "luoqisheng" => "540025011@qq.com" }

  s.source       = { :git => 'https://github.com/luoqisheng/AnnotationKit/blob/master/AnnotationKitDemo/BussinessTwoDylib', :tag => 'v1.0.1' }
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
