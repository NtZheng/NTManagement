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
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end

@implementation NTInformationViewController

const static int imageViewHeight = 150;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.myTableView.contentInset = UIEdgeInsetsMake(imageViewHeight, 0, 0, 0);// 让UITableView的内容向下偏移imageViewHeight这么多距离，空出来用于背景显示
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.section == 0) {
        cell.textLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
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
    CGFloat offsetY = scrollView.contentOffset.y;// UIScrollView（也就是这里的UITableView）在y方向上的偏移量
    CGFloat offsetH = imageViewHeight + offsetY;// 实际上UITableView向下拖动的距离（也就是UIImageView需要添加的高度）
    if (offsetH < imageViewHeight) {// 向下拉动的时候调用
        self.myImageView.height = imageViewHeight - offsetH;// 改变UIImageView的高度（重点：由于我们设置的UIImageView的模式为Aspect Fill，所以系统会这样做->当还没有完全显示UIImageView的时候进行显示，这种显示效果就是UITableView的内容的变化速度看起来比UIImageView的变化速度要快，这是系统的效果，不需要我们实现，接着，当显示完全的时候，那么就按照Aspect Fill这种效果去拉伸图片）
    }
    if (offsetH != 0) {
        self.navigationController.navigationBarHidden = NO;
    }
    self.navigationController.navigationBar.alpha = offsetH/(imageViewHeight - 64);;
}

@end
