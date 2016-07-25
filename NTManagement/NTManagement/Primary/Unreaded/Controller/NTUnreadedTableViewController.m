//
//  NTUnreadedTableViewController.m
//  NTManagement
//
//  Created by 郑祯 on 16/7/6.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTUnreadedTableViewController.h"
#import "NTUnreadedTableViewCell.h"

@interface NTUnreadedTableViewController ()

@end

@implementation NTUnreadedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
    
#pragma mark - dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NTUnreadedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"unreadedCell"];
//    cell.textLabel.text = @"nineten"; //这句代码是不能够写的，如果写了，那么cell就会创建系统的子控件，就会造成自定义的子控件被覆盖了
    cell.nameTextView.text = @"你好吗";
    cell.timeLabel.text = @"上午11:15";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
#pragma mark - delegate
// 取消header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.02;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"goIntoFlowViewController" sender:nil];
}

@end
