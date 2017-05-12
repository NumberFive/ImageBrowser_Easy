//
//  ImageBrowserCell.m
//  Demo
//
//  Created by 伍小华 on 2017/5/12.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "ImageBrowserCell.h"
@interface ImageBrowserCell ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_imageView;
}

@end
@implementation ImageBrowserCell

@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.minZoomScale = 1.0;
        self.maxZoomScale = 3.0;
        _currentScale = self.minZoomScale;
        
        [self.contentView addSubview:self.scrollView];
        [self.scrollView addSubview:self.imageView];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.contentView.bounds;
    self.imageView.frame = self.contentView.bounds;
}

//恢复到最小倍数
- (void)resetState
{
    if (self.currentScale != self.minZoomScale) {
        self.scrollView.zoomScale = self.minZoomScale;
    }
}

//双击放大缩小
- (void)doubleTapGestureAction:(UITapGestureRecognizer *)tapGesture
{
    CGFloat aveScale = self.scrollView.minimumZoomScale + (self.scrollView.maximumZoomScale - self.scrollView.minimumZoomScale)/2.0;//中间倍数
    
    if (self.currentScale == self.scrollView.maximumZoomScale) {
        _currentScale = self.scrollView.minimumZoomScale;
    } else if (self.currentScale == self.scrollView.minimumZoomScale) {
        _currentScale = self.scrollView.maximumZoomScale;
    } else if (self.currentScale >= aveScale) {
        _currentScale = self.scrollView.maximumZoomScale;
    } else if (self.currentScale < aveScale) {
        _currentScale = self.scrollView.minimumZoomScale;
    }
    
    CGRect zoomRect = [self zoomRectForScale:self.currentScale withCenter:[tapGesture locationInView:tapGesture.view]];
    [self.scrollView zoomToRect:zoomRect animated:YES];
}

//调整焦点
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.scrollView.frame.size.height / scale;
    zoomRect.size.width  = self.scrollView.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  /2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height /2.0);
    return zoomRect;
}
#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    _currentScale = scrollView.zoomScale;
}
#pragma mark - Setter / Getter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.maximumZoomScale = self.maxZoomScale;
        _scrollView.minimumZoomScale = self.minZoomScale;
        _scrollView.decelerationRate = 0.1f;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.clipsToBounds = YES;
        _imageView.userInteractionEnabled = YES;
        
        //双击手势
        _doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureAction:)];
        _doubleTapGesture.numberOfTapsRequired = 2;
        [_imageView addGestureRecognizer:_doubleTapGesture];
    }
    return _imageView;
}
@end
