Pod::Spec.new do |s|

    s.name         = 'DTVideoDubbingView'
    s.version      = '1.0.0'
    s.summary      = '视频配音'
    s.description  = '详细描述~'
    s.homepage     = 'https://github.com/LiGGz/XXVideoDubbingView.git'
    s.license      = 'COMMERCIAL'
    s.author       = { 'lg' => 'liiigunang@qq.com' }
    s.platform     = :ios, '8.0'
    s.source       = { :git => "https://github.com/LiGGz/XXVideoDubbingView.git", :branch => s.version.to_s }
    s.requires_arc = true
    s.default_subspecs = 'core'
#    s.resource     = 'src/**/*.{xib,jpeg,mp3,mp4,strings,json}'
    
    s.subspec 'core' do |sp|
        sp.source_files = 'src/**/*.{h,m,swift}' # 源码文件
        sp.private_header_files = 'src/**/*Private.h', 'src/**/*private.h' #私有头文件
        sp.resource_bundles = {
            'DTVideoDubbingView' => [
            'DTVideoDubbingView/**/*.{xib,png,jpg,jpeg,mp3,mp4,strings,json,lproj}'
          ]
        }
    end


    
end
# !!!!end 后一定记得要有换行
