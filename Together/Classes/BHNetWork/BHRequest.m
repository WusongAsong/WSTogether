//
//  BHRequest.m
//  BangHui
//
//  Created by asong on 2020/3/4.
//  Copyright © 2020 com.asong All rights reserved.
//

#import "BHRequest.h"
#import "BHSessionManager.h"
@implementation BHRequest

#pragma mark - post
+ (NSURLSessionDataTask *)postWithAction:(NSString *)action
                              parameters:(NSArray * __nullable)parameters
                                 success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                 failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure{
      return  [[BHSessionManager sharedInstance] request:@"PUT" action:action params:parameters success:success failure:failure];
}


#pragma mark - get
+ (NSURLSessionDataTask *)getWithAction:(NSString *)action
                             parameters:(NSArray * __nullable)parameters
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure{
      return  [[BHSessionManager sharedInstance] request:@"GET" action:action params:parameters success:success failure:failure];
}


@end
