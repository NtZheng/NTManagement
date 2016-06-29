//
//  NTTabBarController.m
//  NTManagement
//
//  Created by 郑祯 on 16/6/29.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTTabBarController.h"
#import "NTLockViewSingleton.h"

@interface NTTabBarController ()

@end

@implementation NTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[NTLockViewSingleton sharedLockViewSingleton].lockIndexMutableArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
