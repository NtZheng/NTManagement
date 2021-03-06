//
//  NTUnreadedDetailsViewController.m
//  NTManagement
//
//  Created by Nineteen on 7/27/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#import "NTUnreadedDetailsViewController.h"
#import "NTFlowViewController.h"

#define buttonWidth ((NTScreenWidth - buttonMargin * 3) / 2)

@interface NTUnreadedDetailsViewController ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *flowButton;
@property (nonatomic, strong) UIButton *signatureButton;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation NTUnreadedDetailsViewController

const int buttonHeight = 50;
const int buttonMargin = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.flowButton];
    [self.view addSubview:self.signatureButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backButton];
    
    [[NTAFNetworking shareAFNetworkingService] doGetRequest:@"http://mountainfile.applinzi.com/returnfileinfo.php?filename=file1&request=info" result:^(id responseObject, NSError *error) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [dictionary objectForKey:@"data"];
        NSString *imageURL = [array objectAtIndex:0];
    }];
    
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

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"文案"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, NTScreenWidth, NTScreenHeight - 100)];
        _scrollView.backgroundColor = [UIColor lightGrayColor];
        _scrollView.contentSize = CGSizeMake(_scrollView.width, self.imageView.height);
        [_scrollView addSubview:self.imageView];
    }
    return _scrollView;
}

- (UIButton *)flowButton {
    if (_flowButton == nil) {
        _flowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _flowButton.size = CGSizeMake(buttonWidth, buttonHeight);
        _flowButton.origin = CGPointMake(buttonMargin, self.scrollView.height + buttonMargin);
        [_flowButton setTitle:@"查看流程" forState:UIControlStateNormal];
        [_flowButton setTitleColor:NTColor forState:UIControlStateNormal];
        _flowButton.layer.cornerRadius = 5;
        _flowButton.layer.borderWidth = 0.5;
        [_flowButton addTarget:self action:@selector(flowButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flowButton;
}

- (UIButton *)signatureButton {
    if (_signatureButton == nil) {
        _signatureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _signatureButton.size = CGSizeMake(buttonWidth, buttonHeight);
        _signatureButton.origin = CGPointMake(buttonMargin + self.flowButton.x + self.flowButton.width, self.scrollView.height + buttonMargin);
        [_signatureButton setTitle:@"审批" forState:UIControlStateNormal];
        [_signatureButton setBackgroundColor:NTColor];
        _signatureButton.layer.cornerRadius = 5;
        [_signatureButton addTarget:self action:@selector(signatureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signatureButton;
}

#pragma mark - methods
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)flowButtonAction {
    [self performSegueWithIdentifier:@"goIntoFlowViewController" sender:nil];
}

- (void)signatureButtonAction {
    [self performSegueWithIdentifier:@"goIntoSignatureViewController" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goIntoFlowViewController"]) {
        ((NTFlowViewController *)segue.destinationViewController).fileName = self.fileName;
    } else if([segue.identifier isEqualToString:@"goIntoSignatureViewController"]) {
        
    }
}

@end
