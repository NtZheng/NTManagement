//
//  NTLoginViewController.m
//  NTManagement
//
//  Created by 郑祯 on 16/6/23.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTLoginViewController.h"
#import "NTLoginTableViewCell.h"

@interface NTLoginViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;

@end

@implementation NTLoginViewController

{
    UIButton *tempButton;// 为了扩展cell中的button的作用范围（在ARC下不用考虑怎么去销毁）
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;

    self.view.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
    
    [self.forgetPasswordButton addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    [self.dismissButton addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma mark - methods
- (void)dismissAction {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)changeIsVisible {
    tempButton.selected = tempButton.selected ? NO : YES;
}

- (void)forgetPasswordAction {
    
}

#pragma mark - dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NTTableViewCell *cell = [[NTTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];// 纯代码自定义cell使用的方法
    NTLoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];// 利用storyboard自定义cell的方法
    if (indexPath.row == 0) {
        cell.myImageView.image = [UIImage imageNamed:@"phoneNumber.png"];
        cell.myTextField.placeholder = @"请输入手机号";
        [cell.myButton removeFromSuperview];// 该栏不显示这个UIButton
    } else {
        cell.myImageView.image = [UIImage imageNamed:@"password.png"];
        cell.myTextField.placeholder = @"请输入密码";
        cell.myTextField.secureTextEntry = YES;
        
        [cell.myButton setBackgroundImage:[UIImage imageNamed:@"invisible.png"] forState:UIControlStateNormal];
        [cell.myButton setBackgroundImage:[UIImage imageNamed:@"visible.png"] forState:UIControlStateSelected];
        [cell.myButton addTarget:self action:@selector(changeIsVisible) forControlEvents:UIControlEventTouchUpInside];
        tempButton = cell.myButton;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


#pragma mark - delegate
// 下面两个方法目的是为了取消header和footer
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.02;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.02;
}




@end
