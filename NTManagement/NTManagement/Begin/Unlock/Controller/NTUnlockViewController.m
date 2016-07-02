//
//  NTUnlockViewController.m
//  NTManagement
//
//  Created by 郑祯 on 16/7/2.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTUnlockViewController.h"
#import "NTUnlockView.h"
#import "MBProgressHUD.h"

@interface NTUnlockViewController ()
@property (weak, nonatomic) IBOutlet NTUnlockView *unlockView;
@end

@implementation NTUnlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
   self.unlockView.finishDrawPath = ^(NSMutableArray *indexMutableArray) {
       if ([indexMutableArray isEqualToArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"lockPathArray"]]) {
           [self performSegueWithIdentifier:@"goIntoPrimaryFromUnlock" sender:nil];
       } else {
           [self showCustomViewWithText:@"密码不正确" image:@"close"];
       }
   };
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - methods
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
