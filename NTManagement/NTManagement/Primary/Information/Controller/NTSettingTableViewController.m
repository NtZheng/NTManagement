//
//  NTSettingTableViewController.m
//  NTManagement
//
//  Created by 郑祯 on 16/7/1.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTSettingTableViewController.h"

@interface NTSettingTableViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation NTSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - methods
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}




@end
