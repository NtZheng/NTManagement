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

const static int imageViewHeight = 100;
const static int imageViewOffsetY = -110;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.contentInset = UIEdgeInsetsMake(imageViewHeight, 0, 0, 0);// 让cell向下移动100
    [self.myTableView sendSubviewToBack:self.myImageView];// 添加到最后
}


#pragma mark - 懒加载
- (UIImageView *)myImageView {
    if (_myImageView == nil) {
        _myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageViewOffsetY, NTScreenWidth, imageViewHeight)];
        _myImageView.image = [UIImage imageNamed:@"阿狸"];
        _myImageView.contentMode = UIViewContentModeScaleAspectFill;// 使用这个模式，放大的时候就会从中间进行放大
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

// 制作拉伸效果主要的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat offsetH = imageViewHeight + offsetY;
    if (offsetH < 0) { //向下拉动的时候调用
        if (offsetH > -25) {// 当0到-25这个时段，不进行拉伸效果
            
        } else {// 如果图片未显示完全，就继续显示，如果显示完全，就进行拉伸
            self.myImageView.height = imageViewHeight - offsetH;// 将高度调高
            self.myImageView.y = imageViewOffsetY + 10 + offsetH;// 下边界是一定的，高度变大了，起始的Y应该上移
        }
    }
}
@end
