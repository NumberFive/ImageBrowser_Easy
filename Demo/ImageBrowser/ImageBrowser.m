//
//  ImageBrowser.m
//  Demo
//
//  Created by 伍小华 on 2017/5/12.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "ImageBrowser.h"
#import "ImageBrowserCell.h"

#define BROWSER_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define BROWSER_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ImageBrowser ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
}

@end
@implementation ImageBrowser
@synthesize collectionView = _collectionView;

- (instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, BROWSER_SCREEN_WIDTH, BROWSER_SCREEN_HEIGHT);
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.collectionView];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)show
{
    [self layoutIfNeeded];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ImageBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageBrowserCell *aCell = (ImageBrowserCell *)cell;
    [aCell resetState];
}

#pragma mark - Setter / Getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[ImageBrowserCell class] forCellWithReuseIdentifier:@"Cell"];
    }
    return _collectionView;
}
@end
