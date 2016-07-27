//
//  NTSignatureViewController.m
//  NTManagement
//
//  Created by Nineteen on 7/27/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#import "NTSignatureViewController.h"
#import "NTPlaceholderTextView.h"

@interface NTSignatureViewController () <UITextViewDelegate>

@property (nonatomic, strong) UIButton *backButton;
@property (weak, nonatomic) IBOutlet NTPlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@end

@implementation NTSignatureViewController

const int distanceOfMoving = 50;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backButton];
    self.textView.placeholder = @"请您在这里填写对于本文件的意见";
    self.textView.delegate = self;
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

#pragma mark - delegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self changeViewUp:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self changeViewUp:NO];
}

#pragma mark - methods
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)changeViewUp:(BOOL)isUp
{
    [UIView beginAnimations:@"textViewMoveUpAndDown" context:nil];
    [UIView setAnimationDuration:0.2f];
    int changedValue;
    if (isUp) {
        changedValue = -distanceOfMoving;
    }else {
        changedValue = distanceOfMoving;
    }
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + changedValue, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}


@end
