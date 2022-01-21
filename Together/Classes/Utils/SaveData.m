//
//  SaveData.m
//  Togetther
//
//  Created by asong on 2022/1/14.
//  Copyright © 2022 com.asong. All rights reserved.
//

#import "SaveData.h"

@implementation SaveData

+ (SaveData *)shardInstance {
    static SaveData *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[SaveData alloc] init];
    });
    return shareInstance;
}



@end
