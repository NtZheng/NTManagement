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
@property (weak, nonatomic) IBOutlet UIView *outerCircleView;

@end

@implementation NTLatestFlowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.segmentLine.backgroundColor = [UIColor lightGrayColor];
    self.circleView.backgroundColor = NTColor;
    self.circleView.layer.cornerRadius = 10;
    self.outerCircleView.backgroundColor = [UIColor colorWithRed:97/255.0 green:147/255.0 blue:224/255.0 alpha:0.5];
    self.outerCircleView.layer.cornerRadius = 14;
}

@end
