//
//  BHSessionManager.h
//  BangHui
//
//  Created by asong on 2020/3/4.
//  Copyright © 2020 com.asong All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "BHConstants.h"
#import "NSDictionary+BHSafeAccess.h"

static NSString * const SHTTPErrorDomain = @"BHHTTPErrorDomain";

@interface BHSessionManager : NSObject
@property(nonatomic) AFHTTPSessionManager * baseRequestManager;

//单例！！！！
+ (BHSessionManager *)sharedInstance;


/**
 一般请求 ！！！！！！！！

 @param method get post put delete and so on (参数拼接在url后面)
 @param action controller的映射地址
 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 @return task
 */
-  (NSURLSessionDataTask *)request:(NSString *)method
                            action:(NSString *)action
                            params:(NSDictionary *)params
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;


@end

