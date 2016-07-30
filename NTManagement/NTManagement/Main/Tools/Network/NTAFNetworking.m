//
//  NTAFNetworking.m
//  NTManagement
//
//  Created by Nineteen on 7/28/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#import "NTAFNetworking.h"

@implementation NTAFNetworking

static NTAFNetworking *_instance;

+ (instancetype)shareAFNetworkingService {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[NTAFNetworking alloc] init];
    });
    return _instance;
}

#pragma mark - methods
- (void)doGetRequest: (NSString *)URL result: (void(^)(id responseObject, NSError *error))resultBlock {
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URL parameters:nil error:nil];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:configuration];
    
    // 下面三句是对于AFN本身的解析格式有限所做的补充操作
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                    resultBlock(responseObject, error);
                                                }];
    [dataTask resume];
}

- (void)doDownloadTask:(NSString *)URL progress:(void (^)(NSProgress *download))downloadBlock handler:(void(^)(NSURLResponse *response, NSURL *filePath, NSError *error))handler
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:downloadBlock destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:handler];
    [downloadTask resume];
}



@end
