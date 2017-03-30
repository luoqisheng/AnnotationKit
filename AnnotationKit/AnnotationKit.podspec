Pod::Spec.new do |s|

  s.name         = "AnnotationKit"
  s.version  = "1.0.0"
  s.summary      = "A short description of AnnotationKit."

  s.description  = <<-DESC
                   先知
                   DESC

  s.homepage     = "http://EXAMPLE/AnnotationKit"
  s.license      = "MIT (example)"
  s.author       = { "luoqisheng" => "qishengluo@gmail.com" }

  s.platform     = :ios, "7.0"
  s.requires_arc = true
  #s.source_files = "AnnotationKit/*/**/*.{h,m,mm}"

  s.subspec 'Core' do |core|
    core.source_files = ["Core/*.{h,m}" , "Category/*.{h,m}"]
    core.requires_arc = true
  end

  s.subspec 'Router' do |rt|
    rt.source_files = 'Router/*.{h,m}'
    rt.requires_arc = true
    rt.dependency 'HHRouter'
    rt.dependency 'AnnotationKit/Core'
  end

  s.subspec 'EventCenter' do |ec|
    ec.source_files = 'EventCenter/*.{h,m}'
    ec.requires_arc = true
    ec.dependency 'AnnotationKit/Core'
  end


  s.xcconfig = {
          'CLANG_CXX_LANGUAGE_STANDARD' => 'compiler-default',
          'CLANG_CXX_LIBRARY' => 'compiler-default',
          'GCC_C_LANGUAGE_STANDARD' => 'compiler-default'
          }


end
