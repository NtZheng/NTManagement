//
//  NTSignatureViewController.m
//  NTManagement
//
//  Created by Nineteen on 7/27/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#import "NTSignatureViewController.h"

@interface NTSignatureViewController ()

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation NTSignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backButton];
}

#pragma mark - 懒加载
- (UIButton *)backButton {
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.size = CGSizeMake(30, 30);
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

#pragma mark - methods
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
