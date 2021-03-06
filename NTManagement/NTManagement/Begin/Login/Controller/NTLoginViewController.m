//
//  NTLoginViewController.m
//  NTManagement
//
//  Created by 郑祯 on 16/6/23.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTLoginViewController.h"
#import "NTLoginTableViewCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

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
    UITextField *phoneTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;

    self.view.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
    
    [self.forgetPasswordButton addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lockPathArray"] != nil) {
        [self performSegueWithIdentifier:@"goIntoUnlock" sender:nil];
    }
//    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]);
}

#pragma mark - methods
- (void)dismissAction {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)forgetPasswordAction {
    
}

- (IBAction)loginAction:(id)sender {
    // 后台交互
    [[NTAFNetworking shareAFNetworkingService] doGetRequest:[NSString stringWithFormat:@"http://mountainfile.applinzi.com/login.php?mobile=%@",phoneTextField.text] result:^(id responseObject, NSError *error) {
        NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (![result isEqualToString:@"0"]) {
            // 保存用户名
            [[NSUserDefaults standardUserDefaults] setObject:[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding] forKey:@"userName"];
            // 保存登录状态
            [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] setObject:phoneTextField.text forKey:@"phoneNumber"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self performSegueWithIdentifier:@"goIntoLock" sender:nil];
        } else {
            [self showCustomViewWithText:@"不存在该用户" image:@"close"];
        }
    }];
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

// 官方demo中的自定义提示的方法
- (void)showCustomViewWithText :(NSString *)text image :(NSString *)imageName {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    // Optional label text.
    hud.labelText = text;
    [hud hide:YES afterDelay:2.f];
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
        phoneTextField = cell.myTextField;
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
