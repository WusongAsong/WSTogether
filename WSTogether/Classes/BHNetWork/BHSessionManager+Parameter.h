//
//  BHSessionManager+Parameter.h
//  BangHui
//
//  Created by asong on 2020/3/4.
//  Copyright © 2020 com.asong All rights reserved.
//
#import "BHSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface BHSessionManager (Parameter)
/**
 手机类型 e. phone6 or phone6s

 @return phone of type
 */
- (NSString*)iphoneType;


+ (UINavigationController *)currentNC;

@end

NS_ASSUME_NONNULL_END
