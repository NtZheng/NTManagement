//
//  NTSettingTableViewController.m
//  NTManagement
//
//  Created by 郑祯 on 16/7/1.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTSettingTableViewController.h"
#import "PassWordTool.h"

@interface NTSettingTableViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation NTSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - methods
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"清除缓存";
    } else {
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor =[UIColor redColor];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark - delegate
// 取出header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.02;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"isLogin"];// 改变登录状态
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"lockPathArray"];// 消除设置的手势解锁
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}



@end
