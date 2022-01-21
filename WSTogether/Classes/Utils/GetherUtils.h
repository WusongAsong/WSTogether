//
//  GetherUtils.h
//  Togetther
//
//  Created by asong on 2022/1/14.
//  Copyright © 2022 com.asong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetherUtils : NSObject
//初始化 ！！！ 单例
+ (GetherUtils *)shardInstance;
//设置基本参数
- (void)setDataWithBaseURL:(NSString *)baseURl WithAppId:(NSString *)appId withAPPName:(NSString *)appName;


- (void)postGatherWithUserid:(NSInteger)userId articleId:(NSInteger)articleId disBehavior:(NSString *)disBehavior mainBehavior:(NSString *)mainBehavior impBehavior:(NSString *)impBehavior duration:(NSString *)duration score:(NSString *)score startTstp:(NSString *)startTstp success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
