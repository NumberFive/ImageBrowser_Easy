//
//  ImageBrowserCell.h
//  Demo
//
//  Created by 伍小华 on 2017/5/12.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageBrowserCell : UICollectionViewCell
@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, assign) CGFloat maxZoomScale;
@property (nonatomic, assign) CGFloat minZoomScale;
@property (nonatomic, assign, readonly) CGFloat currentScale;

@property (nonatomic, strong, readonly) UITapGestureRecognizer *doubleTapGesture;

- (void)resetState;
@end
