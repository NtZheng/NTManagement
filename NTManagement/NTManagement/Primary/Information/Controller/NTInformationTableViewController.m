//
//  NTInformationTableViewController.m
//  NTManagement
//
//  Created by 郑祯 on 16/7/1.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTInformationTableViewController.h"

@interface NTInformationTableViewController ()
@end

@implementation NTInformationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - methods
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = @"nineteen";
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = @"设置";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

#pragma mark - delegate
// 去除headerView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.02;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"goIntoSetting" sender:nil];
    }
}

@end
