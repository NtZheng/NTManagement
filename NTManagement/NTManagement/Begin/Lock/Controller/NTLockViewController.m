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
    [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
    // 这里由于block中会用到self（即为本视图控制器，所以存在循环引用，则采取下面措施防止循环引用）
    __weak NTLockViewController *weakLockViewController = self;
    self.lockView.finishDrawPath = ^(NSMutableArray *indexMutableArray) {
        if (![NTLockViewSingleton sharedLockViewSingleton].isSecondDraw) {// 第一次绘制
            if (indexMutableArray.count < 3) {
                NSLog(@"密码不能小于三位");
            } else {
                weakLockViewController.guideLabel.text = @"请再次绘制";
                [weakLockViewController.lockResultView showResultLockView:indexMutableArray];
                tempMutableArray = indexMutableArray;
                [NTLockViewSingleton sharedLockViewSingleton].isSecondDraw = YES;
            }
        } else {
            if ([indexMutableArray isEqualToArray:tempMutableArray]) {
                [NTLockViewSingleton sharedLockViewSingleton].lockIndexMutableArray = tempMutableArray;// 将这个设备锁保存在单例中
                // 手动跳转
                [self performSegueWithIdentifier:@"goIntoPrimary" sender:nil];
                
            } else {
                NSLog(@"不一样");
            }
        }
    };
    
}

#pragma mark - methods
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
