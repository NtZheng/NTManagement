//
//  NTAFNetworking.h
//  NTManagement
//
//  Created by Nineteen on 7/28/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NTAFNetworking : NSObject

+ (instancetype)shareAFNetworkingService;
- (void)doGetRequest: (NSString *)URL result: (void(^)(id responseObject, NSError *error))resultBlock;

@end
