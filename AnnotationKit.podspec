Pod::Spec.new do |s|

  s.name         = "AnnotationKit"
  s.version  = "1.0.2"
  s.summary      = "an annotation solution using objective-c"

  s.description  = <<-DESC
                   AnnotationKit provides you a way for meta-programming
                   DESC

  s.homepage     = "https://github.com/luoqisheng/AnnotationKit"
  s.license      = "MIT"
  s.author       = { "luoqisheng" => "540025011@qq.com" }

  s.platform     = :ios, "8.0"
  s.requires_arc = true
  s.source       = { :git => 'https://github.com/luoqisheng/AnnotationKit.git', :tag => 'v1.0.2' }

  s.subspec 'Core' do |core|
    core.source_files = ["AnnotationKit/Core/*.{h,m}" , "AnnotationKit/Category/*.{h,m}"]
    core.requires_arc = true
  end

  s.subspec 'Router' do |rt|
    rt.source_files = 'AnnotationKit/Router/*.{h,m}'
    rt.requires_arc = true
    rt.dependency 'AnnotationKit/Core'
    rt.dependency 'HHRouter'
  end

  s.subspec 'EventCenter' do |ec|
    ec.source_files = 'AnnotationKit/EventCenter/*.{h,m}'
    ec.requires_arc = true
    ec.dependency 'AnnotationKit/Core'
  end


  s.xcconfig = {
          'CLANG_CXX_LANGUAGE_STANDARD' => 'compiler-default',
          'CLANG_CXX_LIBRARY' => 'compiler-default',
          'GCC_C_LANGUAGE_STANDARD' => 'compiler-default'
          }


end
