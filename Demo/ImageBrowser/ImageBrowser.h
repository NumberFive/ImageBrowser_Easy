//
//  ImageBrowser.h
//  Demo
//
//  Created by 伍小华 on 2017/5/12.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageBrowser : UIView
@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *imageArray;
- (void)show;
@end
