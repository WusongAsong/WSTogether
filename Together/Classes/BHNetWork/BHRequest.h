//
//  BHRequest.h
//  BangHui
//
//  Created by asong on 2020/3/4.
//  Copyright © 2020 com.asong All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BHRequest : NSObject

+ (NSURLSessionDataTask *_Nonnull)postWithAction:(NSString *_Nullable)action
                              parameters:(NSArray * __nullable)parameters
                                         success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                                         failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;


#pragma mark - get
+ (NSURLSessionDataTask *_Nonnull)getWithAction:(NSString *_Nonnull)action
                             parameters:(NSArray * __nullable)parameters
                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;


@end
