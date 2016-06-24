//
//  NTLoginViewController.m
//  NTManagement
//
//  Created by 郑祯 on 16/6/23.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTLoginViewController.h"

@interface NTLoginViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation NTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
//    self.myTableView.scrollEnabled = NO;
}

#pragma mark - methods
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = @"nineteen";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
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
