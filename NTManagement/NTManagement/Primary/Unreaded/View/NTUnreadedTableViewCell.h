//
//  NTUnreadedTableViewCell.h
//  NTManagement
//
//  Created by 郑祯 on 16/7/6.
//  Copyright © 2016年 nineteen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTUnreadedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *nameTextView;
@property (weak, nonatomic) IBOutlet UIImageView *fileImageView;


@end
