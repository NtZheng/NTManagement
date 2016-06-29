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

// 纯代码属性
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation NTLoginViewController

{
    UIButton *tempButton;// 为了扩展cell.myButton的作用域（需要对cell.myButton的属性进行改变）
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;

    self.view.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
    
    [self.forgetPasswordButton addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

#pragma mark - methods
- (void)dismissAction {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)forgetPasswordAction {
    
}

- (void)timerAction {
    static int number = 60;// 利用static关键字：延长number的生命周期
    [tempButton setTitle:[NSString stringWithFormat:@"等待%d秒",number] forState:UIControlStateNormal];
    number--;
    if (number == -1) {
        [self.timer invalidate];// 销毁NSTimer
        [tempButton setBackgroundColor:NTColor];
        [tempButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        tempButton.userInteractionEnabled = YES;
    }
}

- (void)sendIdentifiedCodeAction {
    tempButton.userInteractionEnabled = NO;// 此时是不能操作UIButton的
    [tempButton setBackgroundColor:[UIColor grayColor]];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

#pragma mark - 懒加载
- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    return _timer;
}

#pragma mark - dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NTTableViewCell *cell = [[NTTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];// 纯代码自定义cell使用的方法
    NTLoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"loginCell"];
    if (indexPath.row == 0) {
        cell.myImageView.image = [UIImage imageNamed:@"phoneNumber.png"];
        cell.myTextField.placeholder = @"请输入手机号";
        [cell.myButton addTarget:self action:@selector(sendIdentifiedCodeAction) forControlEvents:UIControlEventTouchUpInside];
        tempButton = cell.myButton;
    } else {
        cell.myImageView.image = [UIImage imageNamed:@"password.png"];
        cell.myTextField.placeholder = @"请输入密码";
        cell.myTextField.secureTextEntry = YES;
        [cell.myButton removeFromSuperview];
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
