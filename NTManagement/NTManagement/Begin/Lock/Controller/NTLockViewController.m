//
//  NTLockViewController.m
//  NTManagement
//
//  Created by 郑祯 on 16/6/28.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTLockViewController.h"
#import "NTLockResultView.h"
#import "NTLockView.h"
#import "NTLockViewSingleton.h"
#import "MBProgressHUD.h"
#import "PassWordTool.h"

@interface NTLockViewController ()

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet NTLockResultView *lockResultView;
@property (weak, nonatomic) IBOutlet NTLockView *lockView;
@property (weak, nonatomic) IBOutlet UILabel *guideLabel;

@end

@implementation NTLockViewController

{
    NSMutableArray *tempMutableArray;// 用于记录第一次绘制的轨迹

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
    // 这里由于block中会用到self（即为本视图控制器，所以存在循环引用，则采取下面措施防止循环引用）
    __weak NTLockViewController *weakLockViewController = self;
    self.lockView.finishDrawPath = ^(NSMutableArray *indexMutableArray) {
        if (![NTLockViewSingleton sharedLockViewSingleton].isSecondDraw) {// 第一次绘制
            if (indexMutableArray.count < 3) {
                [self showCustomViewWithText:@"密码不能小于三位" image:@"close"];
            } else {
                weakLockViewController.guideLabel.text = @"请再次绘制";
                [weakLockViewController.lockResultView showResultLockView:indexMutableArray];
                tempMutableArray = indexMutableArray;
                [NTLockViewSingleton sharedLockViewSingleton].isSecondDraw = YES;
            }
        } else {
            if ([indexMutableArray isEqualToArray:tempMutableArray]) {
                // 保存在NSUserDefaults中（考虑到安全性不是特别重要，所以使用了NSUserDefault而不是Keychain）
                [[NSUserDefaults standardUserDefaults] setObject:tempMutableArray forKey:@"lockPathArray"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                // 手动跳转
                [self performSegueWithIdentifier:@"goIntoPrimary" sender:nil];
                
            } else {
                
                [self showCustomViewWithText:@"与第一次不符" image:@"close"];
            }
        }
    };
}

#pragma mark - methods
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
@end
