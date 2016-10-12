//
//  HSHttpRequest.m
//  HaierSmart
//
//  Created by andy on 16/4/8.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import "XCHttpRequest.h"
#import "AFNetworking.h"
@interface XCHttpRequest ()
{
    BOOL _isGetType;
    NSString *_urlStr;
    NSDictionary *_paramDic;
    NSDictionary *_headerDic;
}

@end

@implementation XCHttpRequest

#pragma mark - GET

+ (void)GET:(NSString *)url
    Success:(void(^)(id result))success
       Fail:(void(^)(NSError *error))fail {
    [self GET:url
         Head:nil
      Success:^(id result) {
          success(result);
      } Fail:^(NSError *error) {
          fail(error);
      }];
}

+ (void)GET:(NSString *)url
       Head:(NSDictionary *)head
    Success:(void(^)(id result))success
       Fail:(void(^)(NSError *error))fail; {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  @author andy, 16-04-08 13:04:47
     *
     *  添加请求头head
     */
    if (head) {
        for (NSString *key in head) {
            [manager.requestSerializer setValue:head[key] forHTTPHeaderField:key];
        }
    }
    /**
     *  @author andy, 16-04-08 13:04:04
     *
     *  返回类型 默认JSON
     */
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    [manager.requestSerializer setTimeoutInterval:30];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    /* GET请求 */
    [manager GET:url
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             success(responseObject);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             fail(error);
         }];
}

#pragma mark - POST

+ (void)POST:(NSString *)url
        Body:(id)body
     Success:(void(^)(id result))success
        Fail:(void(^)(NSError *error))fail {
    [self POST:url
          Head:nil
          Body:body
       Success:^(id result) {
           success(result);
       }
          Fail:^(NSError *error) {
              fail(error);
          }];
}

+ (void)POST:(NSString *)url
        Head:(NSDictionary *)head
        Body:(id)body
     Success:(void(^)(id result))success
        Fail:(void(^)(NSError *error))fail {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /**
     *  @author andy, 16-04-08 13:04:34
     *
     *  添加请求头head
     */
    if (head) {
        for (NSString *key in head) {
            [manager.requestSerializer setValue:head[key] forHTTPHeaderField:key];
        }
    }
    [manager.requestSerializer setTimeoutInterval:30];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *key = @"CFBundleShortVersionString";//( NSString *)kCFBundleVersionKey;
    NSString *currentVersion = infoDictionary[key];
    
    NSMutableDictionary *app = [[NSMutableDictionary alloc] init];
//    [app setObject:APP_ID forKey:@"app_id"];
//    [app setObject:currentVersion forKey:@"version"];
//    [app setObject:[Utilities getUserId] forKey:@"user_id"];
//    [app setObject:API_Version forKey:@"api_version"];
//    
//    NSMutableDictionary *device = [[NSMutableDictionary alloc] init];
//    [device setObject:@"iOS" forKey:@"platform"];
//    [device setObject:[[UIDevice currentDevice] systemVersion] forKey:@"model"];
//    [device setObject:@"apple" forKey:@"factory"];
//    [device setObject:[NSString stringWithFormat:@"%.2f*%.2f", kSCREEN_SIZE.width, kSCREEN_SIZE.height] forKey:@"screen_size"];
//    [device setObject:@2.0 forKey:@"denstiy"];
//    [device setObject:[HSDeviceID deviceID] forKey:@"imei"];//用uuid 替代imei
//    [device setObject:@"00-00-00-00-00-00" forKey:@"mac"];
//    [device setObject:@"4G" forKey:@"gprs"];
//    [device setObject:USER_LATITUDE forKey:@"latitude"];
//    [device setObject:USER_LONGITUDE forKey:@"longitude"];
    
    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
    [tmp setObject:app forKey:@"app"];
//    [tmp setObject:device forKey:@"device"];
    
    [data setObject:tmp forKey:@"verify_info"];
    if (body != nil) {
        [data setObject:body forKey:@"data"];
    } else {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] init];
        [data setObject:tmpDic forKey:@"data"];
    }
//    NSLog(@"url is : ==>%@<==\nbody is : ==>%@<==", url, [Utilities dictionaryToJsonStr:data]);
    /* POST请求 */
    [manager POST:url
       parameters:data
         progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              
              NSString * jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
              jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n"   withString:@""];
              jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\t"   withString:@""];
              jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"  "   withString:@""];
              NSError *jsonError;
              NSData *objectData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:objectData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&jsonError];
              if (jsonError) {
                  NSLog(@" JSON 解析失败 ： ==>%@<==", jsonError);
                  fail(jsonError);
                  return;
              }
              success(jsonDic);
          }
          failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
              NSLog(@"网络请求失败 ： ==>%@<==", error);
              fail(error);
          }];
}


+ (void)observeNetWorkingStatus{
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态发生改变的时候调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
                
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            default:
                break;
        }
    }];
    // 开始监控
    [mgr startMonitoring];
}








+ (XCHttpRequest *)shareInstance
{
    static XCHttpRequest *request = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[XCHttpRequest alloc]init];
    });
    return request;
}

- (XCHttpRequest *(^)(NSString *))url
{
    return ^XCHttpRequest *(NSString *url){
        _urlStr = url;
        return self;
    };
}

- (XCHttpRequest *(^)(BOOL))isGet
{
    return ^XCHttpRequest *(BOOL isGet){
        _isGetType = isGet;
        return self;
    };
}

- (XCHttpRequest *(^)(NSDictionary *))param
{
    return ^XCHttpRequest *(NSDictionary *param){
        _paramDic = param;
        return self;
    };
}

- (XCHttpRequest *(^)(NSDictionary *))header
{
    return ^XCHttpRequest *(NSDictionary *header){
        _headerDic = header;
        return self;
    };
}

- (void)requestTaskWithSuccess:(void (^)(id))success fail:(void (^)(NSError *))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /**
     *  @author andy, 16-04-08 13:04:34
     *
     *  添加请求头head
     */
    if (_headerDic) {
        for (NSString *key in _headerDic) {
            [manager.requestSerializer setValue:_headerDic[key] forHTTPHeaderField:key];
        }
    }
    [manager.requestSerializer setTimeoutInterval:30];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSMutableDictionary *app = [[NSMutableDictionary alloc] init];
//    [app setObject:APP_ID forKey:@"app_id"];
//    [app setObject:[infoDictionary objectForKey:@"CFBundleVersion"] forKey:@"version"];
//    [app setObject:[Utilities getUserId] forKey:@"user_id"];
//    
//    NSMutableDictionary *device = [[NSMutableDictionary alloc] init];
//    [device setObject:@"iOS" forKey:@"platform"];
//    [device setObject:[[UIDevice currentDevice] systemVersion] forKey:@"model"];
//    [device setObject:@"apple" forKey:@"factory"];
//    [device setObject:[NSString stringWithFormat:@"%.2f*%.2f", kSCREEN_SIZE.width, kSCREEN_SIZE.height] forKey:@"screen_size"];
//    [device setObject:@2.0 forKey:@"denstiy"];
//    [device setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"imei"];//用uuid 替代imei
//    [device setObject:@"00-00-00-00-00-00" forKey:@"mac"];
//    [device setObject:@"4G" forKey:@"gprs"];
//    [device setObject:USER_LATITUDE forKey:@"latitude"];
//    [device setObject:USER_LONGITUDE forKey:@"longitude"];
    
    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
    [tmp setObject:app forKey:@"app"];
//    [tmp setObject:device forKey:@"device"];
    
    [data setObject:tmp forKey:@"verify_info"];
    if (_paramDic != nil) {
        [data setObject:_paramDic forKey:@"data"];
    } else {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] init];
        [data setObject:tmpDic forKey:@"data"];
    }
//    NSLog(@"url is : ==>%@<==\nbody is : ==>%@<==", url, [Utilities dictionaryToJsonStr:data]);
    /* POST请求 */
    [manager POST:_urlStr
       parameters:data
         progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              
              NSString * jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
              jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n"   withString:@""];
              jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\t"   withString:@""];
              jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"  "   withString:@""];
              NSError *jsonError;
              NSData *objectData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:objectData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&jsonError];
              if (jsonError) {
                  NSLog(@" JSON 解析失败 ： ==>%@<==", jsonError);
                  fail(jsonError);
                  return;
              }
              success(jsonDic);
          }
          failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
              NSLog(@"网络请求失败 ： ==>%@<==", error);
              fail(error);
          }];

}

@end
