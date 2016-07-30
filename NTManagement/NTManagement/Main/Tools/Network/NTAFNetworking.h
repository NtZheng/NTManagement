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

#pragma mark - API
- (void)doGetRequest: (NSString *)URL result: (void(^)(id responseObject, NSError *error))resultBlock;
- (void)doDownloadTask:(NSString *)URL progress:(void (^)(NSProgress *download))downloadBlock handler:(void(^)(NSURLResponse *response, NSURL *filePath, NSError *error))handler;

@end
