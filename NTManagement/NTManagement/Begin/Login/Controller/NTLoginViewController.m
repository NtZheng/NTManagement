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
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        [self performSegueWithIdentifier:@"goIntoUnlock" sender:nil];
    }
}

#pragma mark - methods
- (void)dismissAction {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)forgetPasswordAction {
    
}

- (IBAction)loginAction:(id)sender {
    // 保存登录状态
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self performSegueWithIdentifier:@"goIntoLock" sender:nil];
    
    // 后台交互
    [self sendGetRequest];
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

- (void)sendGetRequest {
    NSString *urlStr = @"http://mountainfile.applinzi.com/login.php?mobile=18240439732";
    NSURL *url = [NSURL URLWithString:urlStr];
    // 关于post 方式的话 ，必须使用可变的请求，只有可变请求才能进行 协议方式的设定， 以及请求体等等的设定。
    // 因为不可变请求的话  是默认 get方式的。
    // post的方式比较  保存了 用户的隐私安全 ，将其中用户比较隐私的东西，保存在请求体中吧。
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 设置请求方式  为POST   记住 必须大写。
    request.HTTPMethod = @"GET";
    
//    NSDictionary *header = @{
//                             @"Content-Type": @"application/json"
//                             };
//    request.allHTTPHeaderFields = header;
    
//    NSDictionary *parameters = @{
//                                 @"username": @"ezreal",
//                                 @"phone": @110,
//                                 @"password": @123,
//                                 @"captcha_user": @12,
//                                 @"captcha_wangyi": @12
//                                 };
//    // 设置请求体 ，返回data，  直接用nsstring的方法  ，进行转换。
//    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    
    // 最大访问超时时间。
    request.timeoutInterval = 10;
    
    // 设置请求头内容  ，但一般不要求设置 。用户的手机系统
    [request setValue:@"ios 9.0" forHTTPHeaderField:@"use-Agent-to"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",dataStr);
        NSLog(@"%@",connectionError);
    }];
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
        cell.myTextField.placeholder = @"请输入验证码";
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
