//
//  NTFlowViewController.m
//  NTManagement
//
//  Created by Nineteen on 7/25/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#import "NTFlowViewController.h"
#import "NTNormalFlowTableViewCell.h"

@interface NTFlowViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation NTFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 懒加载
- (UITableView *)myTableView {
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, NTScreenWidth, NTScreenHeight) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

#pragma mark - dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NTNormalFlowTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"NTNormalFlowTableViewCell" owner:nil options:nil] firstObject];
    return cell;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

@end
