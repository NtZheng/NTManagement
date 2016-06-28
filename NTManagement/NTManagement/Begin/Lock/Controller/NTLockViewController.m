//
//  NTLockViewController.m
//  NTManagement
//
//  Created by 郑祯 on 16/6/28.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTLockViewController.h"

@interface NTLockViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation NTLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];

}

#pragma mark - methods
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
