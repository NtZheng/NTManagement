//
//  NTFlowModel.m
//  NTManagement
//
//  Created by Nineteen on 7/29/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#import "NTFlowModel.h"

@implementation NTFlowModel

- (instancetype)initWithDictionary :(NSDictionary *)dic {
    if (self = [super init]) {
        self.name = [dic objectForKey:@"name"];
        self.date = [dic objectForKey:@"date"];
        self.state = [dic objectForKey:@"state"];
    }
    return self;
}

+ (instancetype)modelWithDictionary :(NSDictionary *)dic {
    return [[self alloc] initWithDictionary:dic];
}


@end
