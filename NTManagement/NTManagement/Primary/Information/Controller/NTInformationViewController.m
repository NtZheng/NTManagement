//
//  NTInformationViewController.m
//  NTManagement
//
//  Created by 郑祯 on 16/7/4.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTInformationViewController.h"

@interface NTInformationViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) UIImageView *myImageView;

@end

@implementation NTInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.contentInset = UIEdgeInsetsMake(320, 0, 0, 0);// 让cell向下移动100
    [self.myTableView addSubview:self.myImageView];
}

#pragma mark - 懒加载
- (UIImageView *)myImageView {
    if (_myImageView == nil) {
        _myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -345, NTScreenWidth, 345)];
        _myImageView.image = [UIImage imageNamed:@"xiang"];
        _myImageView.contentMode = UIViewContentModeScaleAspectFill;

//        _myImageView.alpha = 0.5;
        [self.myTableView addSubview:_myImageView];
    }
    return _myImageView;
}




#pragma mark - dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"nineteen";
    } else {
        cell.textLabel.text = @"设置";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
// 去除headerView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.02;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"goIntoSetting" sender:nil];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%f",offsetY);
    CGFloat offsetH = 320 + offsetY;// offsetH是相对的偏移量(偏移量应该是scrollView.contentOffset.y 但是rootTableView.contentInset = UIEdgeInsetsMake(imgHeight, 0, 0, 0)  tableView提前设置便宜了一段距离  所以现在相对的偏移量应该是offsetH)
    if (offsetH < 0) {//下拉偏移为负数
        if (offsetH < -25) {
            CGRect frame = self.myImageView.frame;
            frame.size.height = 320 - offsetH;//下拉后图片的高度应变大
            frame.origin.y = -320 + offsetH;// 下边界是一定的  高度变大了  起始的Y应该上移
            self.myImageView.frame = frame;
        } else {
            
        }
        
        
    }
}
@end
