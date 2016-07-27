//
//  NTSignatureViewController.m
//  NTManagement
//
//  Created by Nineteen on 7/27/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#import "NTSignatureViewController.h"
#import "NTPlaceholderTextView.h"

@interface NTSignatureViewController ()

@property (nonatomic, strong) UIButton *backButton;
@property (weak, nonatomic) IBOutlet NTPlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@end

@implementation NTSignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backButton];
    self.textView.placeholder = @"请您在这里填写对于本文件的意见";
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
