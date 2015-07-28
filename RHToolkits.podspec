Pod::Spec.new do |s|
  s.name         = "RHToolkits"
  s.version      = "1.0.3"
  s.summary      = "RHToolkits: kits by zhuruhong"
  s.homepage     = "https://github.com/zhu410289616/RHToolkits"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "zhu410289616" => "zhu410289616@163.com" }

  s.ios.deployment_target = "6.0"

  s.source       = { :git => "https://github.com/zhu410289616/RHToolkits.git", :tag => s.version, :submodules => true }

  s.default_subspec = "RHViewControllerKit", "RHCategroyKit", "RHToastViewKit", "RHTableViewKit", "RHHttpKit"

  s.subspec "RHViewControllerKit" do |cs|
    cs.source_files  = "RHToolkits/RHViewController/*.{h,m}"
    cs.requires_arc = true
  end

  s.subspec "RHCategroyKit" do |cs|
    cs.source_files  = "RHToolkits/RHCategroy/*.{h,m}"
    cs.requires_arc = true
    cs.dependency 'Base64nl', '~> 1.2'
  end

  s.subspec "RHToastViewKit" do |cs|
    cs.source_files  = "RHToolkits/RHToastView/*.{h,m}"
    cs.requires_arc = true
    cs.dependency 'Masonry', '~> 0.6.1'
    cs.dependency 'RHToolkits/RHCategroyKit'
  end

  s.subspec "RHLoadingViewKit" do |cs|
    cs.source_files  = "RHToolkits/RHLoadingView/*.{h,m}"
    cs.requires_arc = true
    cs.dependency 'MBProgressHUD', '~> 0.9.1'
    cs.dependency 'RHToolkits/RHCategroyKit'
  end

  s.subspec "RHRefreshViewKit" do |cs|
    cs.source_files  = "RHToolkits/RHRefreshView/*.{h,m}"
    cs.requires_arc = true
    cs.dependency 'Masonry', '~> 0.6.1'
  end

  s.subspec "RHTableViewKit" do |cs|
    cs.source_files = "RHToolkits/RHTableView/*.{h,m}"
    cs.requires_arc = true
    cs.dependency 'TTTAttributedLabel', '~> 1.13.4'
    cs.dependency 'RHToolkits/RHRefreshViewKit'
  end

  s.subspec "RHMapKit" do |cs|
    cs.source_files = "RHToolkits/RHMap/*.{h,m}"
    cs.requires_arc = true
    cs.dependency 'AMapNavi', '~> 1.3.0'
  end

  s.subspec "RHHttpKit" do |cs|
    cs.source_files  = "RHToolkits/RHHttp/*.{h,m}"
    cs.requires_arc = true
    cs.dependency 'libextobjc', '~> 0.4.1'
    cs.dependency 'AFNetworking', '~> 2.5.4'
    cs.dependency 'EGOCache', '~> 2.1.3'
    cs.dependency 'RHToolkits/RHCategroyKit'
  end

  s.subspec "RHTaskKit" do |cs|
    cs.source_files  = "RHToolkits/RHTask/*.{h,m}"
    cs.requires_arc = true
  end

end
