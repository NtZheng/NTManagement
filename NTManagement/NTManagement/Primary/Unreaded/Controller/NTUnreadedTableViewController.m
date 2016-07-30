//
//  NTUnreadedTableViewController.m
//  NTManagement
//
//  Created by 郑祯 on 16/7/6.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import "NTUnreadedTableViewController.h"
#import "NTUnreadedTableViewCell.h"
#import "MJRefresh.h"
#import "NTUnreadedFileModel.h"
#import "NTUnreadedDetailsViewController.h"

@interface NTUnreadedTableViewController ()

@property (nonatomic, strong) NSMutableArray *unreadedFiles;

@end

@implementation NTUnreadedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.unreadedFiles = [NSMutableArray array];
        [[NTAFNetworking shareAFNetworkingService] doGetRequest:NTUnreadedFileURL([[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"]) result:^(id responseObject, NSError *error) {
            if (error == nil) {
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSArray *array = [dictionary objectForKey:@"data"];
                for (NSDictionary *dic in array) {
                    [self.unreadedFiles addObject:[NTUnreadedFileModel modelWithDictionary:dic]];
                }
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
            } else {
                
            }
            
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}
    
#pragma mark - dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NTUnreadedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"unreadedCell"];
    cell.nameTextView.text = ((NTUnreadedFileModel *)self.unreadedFiles[indexPath.row]).fileName;
    cell.nameTextView.userInteractionEnabled = NO;
    cell.timeLabel.text = ((NTUnreadedFileModel *)self.unreadedFiles[indexPath.row]).date;
    cell.fileImageView.image = [UIImage imageNamed:@"file"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.unreadedFiles.count;
}

#pragma mark - delegate
// 取消header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.02;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.02;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"goIntoDetailsUnreadedViewController" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NTUnreadedTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.tableView.indexPathForSelectedRow];
    ((NTUnreadedDetailsViewController *)segue.destinationViewController).fileName = cell.nameTextView.text;
}


@end
