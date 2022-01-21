//
//  GetherUtils.m
//  Togetther
//
//  Created by asong on 2022/1/14.
//  Copyright © 2022 com.asong. All rights reserved.
//

#import "GetherUtils.h"
#import "BHConstants.h"
#import "BHRequest.h"
#import "SaveData.h"

@implementation GetherUtils

+ (GetherUtils *)shardInstance {
    static GetherUtils *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[GetherUtils alloc] init];
    });
    return shareInstance;
}

- (void)setDataWithBaseURL:(NSString *)baseURl WithAppId:(NSString *)appId withAPPName:(NSString *)appName {
    [SaveData shardInstance].appId = appId;
    [SaveData shardInstance].appName = appName;
    [SaveData shardInstance].baseURL = baseURl;
}


+(NSString*)getCurrentTimes{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];

    //现在时间,你可以输出来看下是什么格式

    NSDate *datenow = [NSDate date];

    //----------将nsdate按formatter格式转成nsstring

    NSString *currentTimeString = [formatter stringFromDate:datenow];

    NSLog(@"currentTimeString =  %@",currentTimeString);

    return currentTimeString;

}

+(NSString *)getNowTimeTimestamp{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [formatter setTimeZone:timeZone];

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];

    return timeSp;

}

- (void)postGatherWithUserid:(NSInteger)userId articleId:(NSInteger)articleId disBehavior:(NSString *)disBehavior mainBehavior:(NSString *)mainBehavior impBehavior:(NSString *)impBehavior duration:(NSString *)duration score:(NSString *)score startTstp:(NSString *)startTstp success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    if (kSafeStr(disBehavior).length == 0) {
        NSLog(@"分数不能为空");
        return;
    }
    if ((kSafeStr(disBehavior).length == 0) && (kSafeStr(impBehavior).length == 0)) {
        NSLog(@"行为不能为空");
    }
    
    NSDictionary *dict = @{@"appId":[SaveData shardInstance].appId,
                           @"appName":[SaveData shardInstance].appName,
                           @"userId":@(userId),
                           @"mainBehavior":mainBehavior,
                           @"articleId":@(articleId),
                           @"disBehavior":disBehavior,
                           @"impBehavior":impBehavior,
                           @"duration":duration,
                           @"score":score,
                           @"startTstp":[GetherUtils getCurrentTimes],};
    
    [BHRequest postWithAction:[SaveData shardInstance].baseURL parameters:dict success:success failure:failure];
    
//    [BHRequest postWithAction:[SaveData shardInstance].baseURL parameters:@[dict] success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
//        NSLog(@"成功了：%@",[responseObject description] );
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
//        NSLog(@"失败了");
//    }];
    
}

@end
