//
//  SaveData.h
//  Togetther
//
//  Created by asong on 2022/1/14.
//  Copyright © 2022 com.asong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaveData : NSObject
//初始化 ！！！ 单例
+ (SaveData *)shardInstance;

// appID
@property (copy, nonatomic) NSString *appId;
// appName
@property (copy, nonatomic) NSString *appName;
// url
@property (copy, nonatomic) NSString *baseURL;

@end

NS_ASSUME_NONNULL_END
