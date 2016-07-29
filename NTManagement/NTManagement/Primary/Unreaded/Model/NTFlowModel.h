//
//  NTFlowModel.h
//  NTManagement
//
//  Created by Nineteen on 7/29/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTFlowModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *state;

+ (instancetype)modelWithDictionary :(NSDictionary *)dic;
- (instancetype)initWithDictionary :(NSDictionary *)dic;

@end
