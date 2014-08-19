//
//  ViewController.m
//  Demo
//
//  Created by Thomas Joulin on 8/19/14.
//  Copyright (c) 2014 Thomas Joulin. All rights reserved.
//

#import "ViewController.h"
#import "TJCollectionViewColumnFlowLayout.h"
#import "CollectionViewCell.h"
#import "CollectionViewHeader.h"

@interface ViewController () <TJCollectionViewColumnFlowDelegateLayout, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    TJCollectionViewColumnFlowLayout *layout = [[TJCollectionViewColumnFlowLayout alloc] init];

    layout.headerReferenceSize = CGSizeMake(240, 50);
    layout.interitemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(24, 0, 0, 0);

    self.collectionView.contentInset = UIEdgeInsetsMake(15, 80, 15, 80);

    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionViewHeader"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectionViewFooter"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];

    self.collectionView.collectionViewLayout = layout;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 17;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arc4random_uniform(4) + 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return CGSizeMake(240, 31);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        CollectionViewHeader *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CollectionViewHeader" forIndexPath:indexPath];

        view.titleLabel.text = [NSString stringWithFormat:@"Header %d", indexPath.section];

        return view;
    }

    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];

    cell.titleLabel.text = [NSString stringWithFormat:@"Cell {%d, %d}", indexPath.section, indexPath.row];

    return cell;
}

@end
