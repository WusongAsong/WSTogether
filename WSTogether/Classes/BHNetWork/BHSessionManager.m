//
//  BHSessionManager.m
//  BangHui
//
//  Created by asong on 2020/3/4.
//  Copyright © 2020 com.asong All rights reserved.
//

#import "BHSessionManager.h"
#import "BHSessionManager+Parameter.h"
#import "SaveData.h"


static BHSessionManager * sharedInstance = nil;
static dispatch_queue_t serialQueue;

@implementation BHSessionManager

#pragma mark 创建单例
+ (BHSessionManager *)sharedInstance {
    static dispatch_once_t onceQueue;
    dispatch_once(&onceQueue, ^{
        sharedInstance = [[BHSessionManager alloc] init];
    });
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    static dispatch_once_t onceQueue;
    dispatch_once(&onceQueue, ^{
        serialQueue = dispatch_queue_create("com.asong.JSSessionManagerInitQueue", NULL);
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
        }
    });
    return sharedInstance;
}

#pragma mark - 数据初始化
- (id)init {
    id __block obj;
    
    dispatch_sync(serialQueue, ^{
        obj = [super init];
        if (obj) {
            
            self.baseRequestManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[SaveData shardInstance].baseURL]];
            
            //增加这几行代码；
            AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
            [securityPolicy setAllowInvalidCertificates:YES];
            [self.baseRequestManager setSecurityPolicy:securityPolicy];
            
            self.baseRequestManager.requestSerializer = [AFJSONRequestSerializer serializer]; //不设置会报-1016或者会有编码问题
            [self.baseRequestManager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
            [self.baseRequestManager.requestSerializer setValue:@"true" forHTTPHeaderField:@"isTree"];
            [self.baseRequestManager.requestSerializer setValue:@"true" forHTTPHeaderField:@"isLastPage"];
            [self.baseRequestManager.requestSerializer setValue:@"Keep-Alive" forHTTPHeaderField:@"connection"];

            self.baseRequestManager.responseSerializer  = [AFJSONResponseSerializer serializer];
            self.baseRequestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];;
            self.baseRequestManager.requestSerializer.timeoutInterval = 20.0f;
            
        }
    });
    self = obj;
    return self;
}

#pragma mark - 自己的带参数的 get post(参数是放在url后面) +++++++++++++++++++++++++
-  (NSURLSessionDataTask *)request:(NSString *)method
                            action:(NSString *)action
                            params:(NSDictionary *)params
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    
    //对字符baseUrl的拼接
    NSString * baseUrl = [NSString stringWithFormat:@"%@",action];
    NSLog(@"baseUrl :%@",baseUrl);
    
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.baseRequestManager.requestSerializer
                                    requestWithMethod:method
                                    URLString:baseUrl     parameters:params
                                    error:&serializationError];
    //请求头
    [self paraHeaderWithRequest:request];
 

    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        return nil;
    }
    void(^sucessBlock)(NSURLSessionDataTask *operation, id responseObject) = ^void(NSURLSessionDataTask *operation, id responseObject){
        //打印URl
        NSLog(@"Did %@ %@",operation.currentRequest.HTTPMethod,operation.currentRequest.URL);
        if (success) {
            success(operation,responseObject);
        }
    };
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.baseRequestManager dataTaskWithRequest:request
                                             uploadProgress:nil
                                           downloadProgress:nil
                                          completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                                              if (responseObject == nil) {
                                                  failure(dataTask , error);
                                              }else{
                                                  if (sucessBlock) {
                                                      sucessBlock(dataTask, responseObject);
                                                  }
                                                  if ([responseObject jk_integerForKey:@"code"] != 0 || responseObject[@"code"] == nil) {
                                                      [self errorCodeManage:responseObject[@"detail"]];
                                                  }
                                              }
                                              
                                          }];
    [dataTask resume];
    return dataTask;
}

- (void)paraHeaderWithRequest:(NSMutableURLRequest *)request{
    //手机系统版本：e. 9.1.0
    NSString * phoneVersion = [[UIDevice currentDevice] systemVersion];
    //手机类型：iPhone 6
    NSString * phoneType = [self iphoneType];
    //手机系统：OS  :e. iOS   Andiod h5
    NSString * osName = [[UIDevice currentDevice] systemName];
    // 获取App的版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    //设备uuid
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [request  setValue:appVersion forHTTPHeaderField:@"X-app-version"];
    [request  setValue:phoneVersion forHTTPHeaderField:@"X-phone-version"];
    [request  setValue:phoneType forHTTPHeaderField:@"X-phone-type"];
    [request  setValue:osName forHTTPHeaderField:@"X-os"];
    
    [request  setValue:deviceUUID forHTTPHeaderField:@"X-device-uuid"];

//    [request  setValue:[AccountManage getUserIdDes] forHTTPHeaderField:@"Authorization"];
    
}


/// 处理接口返回的错误信息
- (void)errorCodeManage:(NSString *)error{
    if ([error isEqualToString:@"身份认证信息未提供。"]) {
//        [AppManager goToLoginVC];
    }
}

@end
