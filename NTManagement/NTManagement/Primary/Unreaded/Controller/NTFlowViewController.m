//
//  NTFlowViewController.m
//  NTManagement
//
//  Created by Nineteen on 7/25/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#import "NTFlowViewController.h"
#import "NTNormalFlowTableViewCell.h"
#import "NTLatestFlowTableViewCell.h"

@interface NTFlowViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation NTFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backButton];
}

#pragma mark - 懒加载
- (UITableView *)myTableView {
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, NTScreenWidth, NTScreenHeight) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

- (UIButton *)backButton {
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.size = CGSizeMake(30, 30);
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}


#pragma mark - dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NTLatestFlowTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"NTLatestFlowTableViewCell" owner:nil options:nil] firstObject];
        cell.userInteractionEnabled = NO;
        return cell;
    } else {
        NTNormalFlowTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"NTNormalFlowTableViewCell" owner:nil options:nil] firstObject];
        cell.userInteractionEnabled = NO;
        return cell;
    }
    
        }

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.02;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.02;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

#pragma mark - methods
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
