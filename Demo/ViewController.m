//
//  ViewController.m
//  Demo
//
//  Created by 伍小华 on 2017/5/12.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "ViewController.h"
#import "ImageBrowser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor brownColor];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.center = self.view.center;
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)buttonAction
{
    ImageBrowser *browser = [[ImageBrowser alloc] init];
    browser.imageArray = @[@"placeholder.jpg",
                           @"placeholder.jpg",
                           @"placeholder.jpg",
                           @"placeholder.jpg",
                           @"placeholder.jpg"];
    [browser show];
}



@end
