//
//  TJCollectionViewColumnFlowLayout.m
//
//  Created by Thomas Joulin on 8/18/14.
//  Copyright (c) 2014 Thomas Joulin. All rights reserved.
//

#import "TJCollectionViewColumnFlowLayout.h"

@interface TJCollectionViewColumnFlowLayout ()

@property (nonatomic, weak) id <TJCollectionViewColumnFlowDelegateLayout> delegate;
@property (nonatomic, strong) NSMutableArray *itemsAttributes;
@property (nonatomic, strong) NSMutableArray *headersAttributes;
@property (nonatomic, strong) NSMutableArray *footersAttributes;
@property (nonatomic, assign) CGFloat        maxX;

@end

@implementation TJCollectionViewColumnFlowLayout

- (void)commonInit
{
    _columnSpacing = 0;
    _interitemSpacing = 0;
    _sectionInset = UIEdgeInsetsZero;
    _itemSize = CGSizeMake(320, 44);
    _headerReferenceSize = CGSizeZero;
    _footerReferenceSize = CGSizeZero;
    _headersAttributes = [[NSMutableArray alloc] init];
    _footersAttributes = [[NSMutableArray alloc] init];
    _itemsAttributes = [[NSMutableArray alloc] init];
}

- (id)init
{
    if (self = [super init])
    {
        [self commonInit];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self commonInit];
    }

    return self;
}

- (void)prepareLayout
{
    CGFloat         currentY = 0;
    NSInteger       currentColumn = 0;
    NSMutableArray  *currentColumnAttributes = [[NSMutableArray alloc] init];

    self.maxX = 0;
    [self.itemsAttributes removeAllObjects];
    [self.headersAttributes removeAllObjects];
    [self.footersAttributes removeAllObjects];

    for (NSInteger section = 0; section < [self.collectionView numberOfSections]; section++)
    {
        UICollectionViewLayoutAttributes *attributes;
        CGSize          headerSize = self.headerReferenceSize;
        CGSize          footerSize = self.footerReferenceSize;
        CGFloat         interitemSpacing = self.interitemSpacing;
        UIEdgeInsets    sectionInsets = self.sectionInset;
        NSInteger       itemCount = [self.collectionView numberOfItemsInSection:section];
        NSMutableArray  *sectionAttributes = [[NSMutableArray alloc] init];

        if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)])
        {
            headerSize = [self.delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:section];
        }

        if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)])
        {
            footerSize = [self.delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:section];
        }

        if ([self.delegate respondsToSelector:@selector(collectionView:layout:interitemSpacingForSectionAtIndex:)])
        {
            interitemSpacing = [self.delegate collectionView:self.collectionView layout:self interitemSpacingForSectionAtIndex:section];
        }

        if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)])
        {
            sectionInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
        }

        if (headerSize.height > 0)
        {
            attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            attributes.frame = CGRectMake(sectionInsets.left + (currentColumn * headerSize.width), sectionInsets.top + currentY, headerSize.width, headerSize.height);
            [self.headersAttributes addObject:attributes];

            currentY += sectionInsets.top + headerSize.height;
        }

        for (NSInteger itemIndex = 0; itemIndex < itemCount; itemIndex++)
        {
            NSIndexPath                      *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:section];
            CGSize                           size = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

            attributes.frame = CGRectMake(sectionInsets.left + (currentColumn * size.width), currentY, size.width, size.height);

            self.maxX = fmaxf(attributes.frame.origin.x + attributes.frame.size.width, self.maxX);
            [sectionAttributes addObject:attributes];
            currentY += size.height + interitemSpacing;
        }

        if (footerSize.height > 0)
        {
            attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            attributes.frame = CGRectMake(sectionInsets.left + (currentColumn * footerSize.width), currentY, footerSize.width, footerSize.height);
            [self.footersAttributes addObject:attributes];

            currentY += footerSize.height + sectionInsets.bottom;
        }

        currentY += sectionInsets.bottom;

        if (currentY > (self.collectionView.bounds.size.height - self.collectionView.contentInset.top - self.collectionView.contentInset.bottom))
        {
            if (!currentColumnAttributes.count)
            {
                @throw [NSException exceptionWithName:@"SCTCollectionViewLayoutException"
                                               reason:[NSString stringWithFormat:@"Collection view height (%.2f) too small to fit all items at section %d (needs to be at least %.2f)", self.collectionView.bounds.size.height, section, currentY]
                                             userInfo:nil];
            }

            [self.itemsAttributes addObjectsFromArray:currentColumnAttributes];

            currentColumnAttributes = [[NSMutableArray alloc] init];
            currentColumn += 1;
            currentY = 0;
            section -= 1;

            [self.headersAttributes removeLastObject];
            [self.footersAttributes removeLastObject];
        }
        else if (section == [self.collectionView numberOfSections] - 1)
        {
            [currentColumnAttributes addObjectsFromArray:sectionAttributes];

            [self.itemsAttributes addObjectsFromArray:currentColumnAttributes];
        }
        else
        {
            [currentColumnAttributes addObjectsFromArray:sectionAttributes];
        }
    };
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.itemsAttributes[indexPath.row][indexPath.section];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = nil;

    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        attribute = self.headersAttributes[indexPath.section];
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        attribute = self.footersAttributes[indexPath.section];
    }

    return attribute;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributesArray = [[NSMutableArray alloc] init];

    for (UICollectionViewLayoutAttributes *attributes in self.itemsAttributes)
    {
        if (CGRectIntersectsRect(rect, attributes.frame))
        {
            [attributesArray addObject:attributes];
        }
    }

    for (UICollectionViewLayoutAttributes *attributes in self.headersAttributes)
    {
        if (CGRectIntersectsRect(rect, attributes.frame))
        {
            [attributesArray addObject:attributes];
        }
    }

    for (UICollectionViewLayoutAttributes *attributes in self.footersAttributes)
    {
        if (CGRectIntersectsRect(rect, attributes.frame))
        {
            [attributesArray addObject:attributes];
        }
    }

    return [attributesArray copy];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return CGRectGetWidth(newBounds) != CGRectGetWidth(self.collectionView.bounds);
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(fmaxf(self.maxX, (self.collectionView.bounds.size.width - self.collectionView.contentInset.left - self.collectionView.contentInset.right)),
                      self.collectionView.bounds.size.height - self.collectionView.contentInset.top - self.collectionView.contentInset.bottom);
}

- (id<TJCollectionViewColumnFlowDelegateLayout>)delegate
{
    return (id<TJCollectionViewColumnFlowDelegateLayout>)self.collectionView.delegate;
}

@end
