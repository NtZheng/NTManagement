//
//  NTUnreadedFileModel.h
//  NTManagement
//
//  Created by Nineteen on 7/28/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTUnreadedFileModel : NSObject

@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *date;

- (instancetype)initWithDictionary :(NSDictionary *)dictionary;
+ (instancetype)modelWithDictionary :(NSDictionary *)dictionary;

@end
