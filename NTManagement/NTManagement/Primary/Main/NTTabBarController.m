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
    // 定制UITabBarItem的title的颜色
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
