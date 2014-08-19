TJCollectionViewColumnFlowLayout
===============================

This layout flows sections horizontally, going to the next column if section reaches the bottom of the collection view

Screen Shots
------------

![TJCollectionViewColumnFlowLayout in landscape](https://raw.githubusercontent.com/thomasjoulin/TJCollectionViewColumnFlowLayout/master/Screenshots/landscape.png)

Prerequisite
------------
* ARC
* Xcode 4.4+, which supports literals syntax.
* iOS 6+, or
* iOS 4.x/5.x, with [PSTUICollectionView].

How to install
--------------
* [CocoaPods]  
  Add `pod 'TJCollectionViewColumnFlowLayout'` to your podfile.
* Manual  
  Copy `TJCollectionViewColumnFlowLayout.h/m` to your project.

How to Use
----------
Read the demo codes for detail information.

Todo
----------
* Variable column width, based on biggest element inside the column
* Left/Right section inset support

License
-------
TJCollectionViewColumnFlowLayout is available under the MIT license. See the LICENSE file for more info.

Special Thanks
-----------
Special thanks to [Michał Kałużny](https://github.com/justMaku) ([@justMaku](https://twitter.com/justMaku)) for helping with initial implementation

[PSTUICollectionView]: https://github.com/steipete/PSTCollectionView
[CocoaPods]: http://cocoapods.org/
