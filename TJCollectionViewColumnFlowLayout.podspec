Pod::Spec.new do |s|
  s.name         = "TJCollectionViewColumnFlowLayout"
  s.version      = "0.1"
  s.summary      = "A layout that flows sections horizontally, going to the next column if section reaches the bottom of the collection view"
  s.homepage     = "https://github.com/thomasjoulin/TJCollectionViewColumnFlowLayout"
  s.screenshots  = "https://github.com/thomasjoulin/TJCollectionViewColumnFlowLayout/master/Screenshots/2-columns.png", "https://raw.github.com/chiahsien/UICollectionViewWaterfallLayout/master/Screenshots/3-columns.png"
  s.license      = 'MIT'
  s.author       = { "Thomas Joulin" => "thomas@joulin.eu" }
  s.source       = { :git => "https://github.com/thomasjoulin/TJCollectionViewColumnFlowLayout.git", :tag => "#{s.version}" }
  s.platform     = :ios, '6.0'
  s.source_files = '*.{h,m}'
  s.requires_arc = true
end
