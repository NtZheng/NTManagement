//
//  NTUnreadedFileModel.m
//  NTManagement
//
//  Created by Nineteen on 7/28/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#import "NTUnreadedFileModel.h"

@implementation NTUnreadedFileModel

- (instancetype)initWithDictionary :(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.fileName = [dictionary objectForKey:@"fileName"];
        self.date = [dictionary objectForKey:@"date"];
    }
    return self;
}

+ (instancetype)modelWithDictionary :(NSDictionary *)dictionary {
    return [[self alloc]initWithDictionary:dictionary];
}

@end
