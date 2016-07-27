//
//  NTLatestFlowTableViewCell.m
//  NTManagement
//
//  Created by Nineteen on 7/27/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#import "NTLatestFlowTableViewCell.h"

@interface NTLatestFlowTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UIView *segmentLine;

@end

@implementation NTLatestFlowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.segmentLine.backgroundColor = [UIColor lightGrayColor];
    self.circleView.backgroundColor = NTColor;
}

@end
