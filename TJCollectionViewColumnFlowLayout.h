//
//  TJCollectionViewColumnFlowLayout.h
//
//  Created by Thomas Joulin on 8/18/14.
//  Copyright (c) 2014 Thomas Joulin. All rights reserved.
//

@protocol TJCollectionViewColumnFlowDelegateLayout <UICollectionViewDelegate>

@optional
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout interitemSpacingForSectionAtIndex:(NSInteger)section;

@end

@interface TJCollectionViewColumnFlowLayout : UICollectionViewLayout

@property (nonatomic) CGFloat      columnSpacing;
@property (nonatomic) CGFloat      interitemSpacing;
@property (nonatomic) CGSize       itemSize;
@property (nonatomic) CGSize       headerReferenceSize;
@property (nonatomic) CGSize       footerReferenceSize;
@property (nonatomic) UIEdgeInsets sectionInset;

@end
