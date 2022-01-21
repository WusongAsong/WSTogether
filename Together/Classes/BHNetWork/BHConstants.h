//
//  BHConstants.h
//  Togetther
//
//  Created by asong on 2022/1/14.
//  Copyright © 2022 com.asong. All rights reserved.
//

#ifndef BHConstants_h
#define BHConstants_h

#define BlockWeakObject(o) __typeof(o) __weak
#define BlockWeakSelf BlockWeakObject(self)

#define WEAKSELF __weak typeof(self) weakSelf = self;
#define STRONGSELF __strong typeof(weakSelf) self = weakSelf;

#define kSafeStr(str) ((!str || ![str isKindOfClass:[NSString class]]) ? @"" : str)

#endif /* BHConstants_h */
