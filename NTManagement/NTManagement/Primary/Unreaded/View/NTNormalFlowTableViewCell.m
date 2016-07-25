//
//  NTNormalFlowTableViewCell.m
//  NTManagement
//
//  Created by Nineteen on 7/25/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#import "NTNormalFlowTableViewCell.h"

@interface NTNormalFlowTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *segmentLine;
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation NTNormalFlowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.segmentLine.backgroundColor = [UIColor lightGrayColor];
    self.circleView.backgroundColor = [UIColor grayColor];
    self.circleView.layer.cornerRadius = 8;
}

@end
