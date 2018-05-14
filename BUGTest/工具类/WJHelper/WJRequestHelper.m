//
//  WJRequestHelper.m
//  JDZS
//
//  Created by Mac on 2018/3/28.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "WJRequestHelper.h"

#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

@implementation WJRequestHelper

static NSMutableArray       *_allSessionTask;
static AFHTTPSessionManager *_sessionManager;


//  开始监测网络状态
+ (void)load
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

/*  所有的HTTP请求共享一个AFHTTPSessionManager
 *  原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */
+ (void)initialize
{
    _sessionManager = [AFHTTPSessionManager manager];
#warning AAAAA 这两句话在参考的 PPNetworkHelper中是没有的，需要进一步研究
    // 这两句话要写上的，不然网络请求回来的时候会崩溃，报“实例找不到错误”
    _sessionManager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    _sessionManager.requestSerializer.timeoutInterval = 10.f;
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];

}

//  取消所有HTTP请求
+ (void)cancelAllRequest
{
    // 锁操作
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

//  取消指定URL的HTTP请求
+ (void)cancelRequestWithURL:(NSString *)URL
{
    if (!URL) { return; }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",WJ_SERVLET,URL];
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:urlStr]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

/*  设置请求头
 *
 *  @param dic  A：dic   == nil  取消请求头
                B：count == 0    设置请求头
                C：count >  0    自定义请求头（暂不考虑）
 *
 *  return 无返回值
 */
+ (void)setHTTPHeaderFieldForDic:(NSDictionary *)dic
{
    if (dic) {
        if (dic.count == 0) {
            [_sessionManager.requestSerializer setValue:[WJStringHelper getNotEmptyStr:[USER_D objectForKey:AUTH_KEY]] forHTTPHeaderField:@"authKey"];
            [_sessionManager.requestSerializer setValue:[WJStringHelper getNotEmptyStr:[USER_D objectForKey:SESSION_ID]] forHTTPHeaderField:@"sessionId"];
        }
        else
        {
            // 自定义设置暂时不处理，需要时候再说
        }
    }
    else
    {
        [_sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"authKey"];
        [_sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"sessionId"];
    }
}


/*  发送post请求
 *
 *  @param URLString  用来拼接完整的url
 *  @param HTTPHeader 请求头（nil不设置、@{}默认设置、dic自定义设置）
 *  @param dic        参数字典
 *  @param success    请求成功(success)的回调，回传值为NSDictionary
 *  @param failure    请求成功(fail)的回调，回传值为NSDictionary
 *  @param errorBlock 请求失败的回调，回传值为NSError
 *
 *  return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)postRequest:(NSString *)URLString
                                HTTPHeader:(NSDictionary *)HTTPHeader
                                parameters:(NSDictionary *)dic
                                   success:(void (^)(NSDictionary *successDict))success
                                   failure:(void (^)(NSDictionary *failDict))failure
                                errorBlock:(void (^)(NSError *error))errorBlock
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WJ_SERVLET,URLString]];
    [self setHTTPHeaderFieldForDic:HTTPHeader]; // 设置请求头
    NSURLSessionTask *sessionTask = [_sessionManager POST:url.absoluteString
                                               parameters:dic
                                                 progress:nil
                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         /*  网络请求返回值
          *
          *  @param code：    200 - 请求成功      400 - 请求失败
          *  @param data：    数据
          *  @param error：   请求失败的 错误描述
          *  @param param：   暂时不用管
          */
         NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSLog(@"请求成功：%@",str);
         [[self allSessionTask] removeObject:task];
         NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         if ([[resultDic objectForKey:@"code"] integerValue] == 200) {
             success ? success(resultDic) : nil;
         }
         else if ([[resultDic objectForKey:@"code"] integerValue] == 400) {
             failure ? failure(resultDic) : nil;
         }
         else
         {
             SHOW_ERROR_DETAIL_HUD(@"未知情况", @"返回的不是400 也不是200", 1)
             errorBlock ? errorBlock(nil) : nil;
         }
     }
                                                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"请求失败：%@",error);
         [[self allSessionTask] removeObject:task];
         errorBlock ? errorBlock(error) : nil;
     }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    return sessionTask;
}

/*  发送GET请求
 *
 *  @param URLString  用来拼接完整的url
 *  @param dic        参数字典
 *  @param success    请求成功(success)的回调，回传值为NSDictionary
 *  @param failure    请求成功(fail)的回调，回传值为NSDictionary
 *  @param errorBlock 请求失败的回调，回传值为NSError
 *
 *  return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)getRequest:(NSString *)URLString
                               HTTPHeader:(NSDictionary *)HTTPHeader
                               parameters:(NSDictionary *)dic
                                  success:(void (^)(NSDictionary *successDict))success
                                  failure:(void (^)(NSDictionary *failDict))failure
                               errorBlock:(void (^)(NSError *error))errorBlock
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WJ_SERVLET,URLString]];
    [self setHTTPHeaderFieldForDic:HTTPHeader];
    NSURLSessionTask *sessionTask = [_sessionManager GET:url.absoluteString
                                              parameters:dic
                                                progress:nil
                                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"请求成功：%@",str);
        [[self allSessionTask] removeObject:task];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"code"] integerValue] == 200) {
            success ? success(resultDic) : nil;
        }
        else if ([[resultDic objectForKey:@"code"] integerValue] == 400) {
            failure ? failure(resultDic) : nil;
        }
        else
        {
            SHOW_ERROR_DETAIL_HUD(@"未知情况", @"返回的不是400 也不是200", 1)
            errorBlock ? errorBlock(nil) : nil;
        }
     }
                                                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"请求失败：%@",error);
         [[self allSessionTask] removeObject:task];
         errorBlock ? errorBlock(error) : nil;
     }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    return sessionTask;
}


/*  上传单/多张图片
 *
 *  @param URL        请求地址(在外部需要直接写全)
 *  @param parameters 请求参数
 *  @param name       图片对应服务器上的字段
 *  @param images     图片数组
 *  @param fileNames  图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 *  @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
 *  @param imageType  图片文件的类型,例:png、jpg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功(success)的回调，回传值为NSDictionary
 *  @param failure    请求成功(fail)的回调，回传值为NSDictionary
 *  @param errorBlock 请求失败的回调，回传值为NSError
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                                        parameters:(id)parameters
                                              name:(NSString *)name
                                            images:(NSArray<UIImage *> *)images
                                         fileNames:(NSArray<NSString *> *)fileNames
                                        imageScale:(CGFloat)imageScale
                                         imageType:(NSString *)imageType
                                          progress:(void (^)(NSProgress *progress))progress
                                           success:(void (^)(NSDictionary *successDict))success
                                           failure:(void (^)(NSDictionary *failDict))failure
                                        errorBlock:(void (^)(NSError *error))errorBlock
{
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL
                                               parameters:parameters
                                constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            
            // 默认图片的文件名, 若fileNames为nil就使用
            NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
            formatter.dateFormat        = @"yyyyMMddHHmmss";
            NSString *str               = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName     = NSStringFormat(@"%@%ld.%@",str,i,imageType?:@"jpg");

            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? NSStringFormat(@"%@.%@",fileNames[i],imageType?:@"jpg") : imageFileName
                                    mimeType:NSStringFormat(@"image/%@",imageType ?: @"jpg")];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"请求成功：%@",str);
        [[self allSessionTask] removeObject:task];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"code"] integerValue] == 200) {
            success ? success(resultDic) : nil;
        }
        else if ([[resultDic objectForKey:@"code"] integerValue] == 400) {
            failure ? failure(resultDic) : nil;
        }
        else
        {
            SHOW_ERROR_DETAIL_HUD(@"未知情况", @"返回的不是400 也不是200", 1)
            errorBlock ? errorBlock(nil) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self allSessionTask] removeObject:task];
        errorBlock ? errorBlock(nil) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
}


/*  阿里天气专用请求
 *
 *  @param appLaunch    区别是不是按照坐标请求
 *  @param querys       参数：IP、或经纬度（维度在前）
 *  @param weatherData  天气数据
 *
 *  return 无返回值
 */
+ (void)weatherForCoordinates:(BOOL)isCoordinates
                       querys:(NSString *)querys
                  weatherData:(void (^)(NSString *weatherDes))weatherData
{
    NSString *appcode   = @"45cc7b44fe5a43b3a721ee0a658ff899";
    NSString *host      = @"http://jisutianqi.market.alicloudapi.com";
    NSString *path      = @"/weather/query";
    NSMutableDictionary *dic = [@{} mutableCopy];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", host, path]];
    if (isCoordinates) {
        [dic setObject:querys forKey:@"location"];
    }
    else
    {
        [dic setObject:querys forKey:@"ip"];
    }
    
    [_sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"APPCODE %@",appcode] forHTTPHeaderField:@"Authorization"];
    NSURLSessionTask *sessionTask = [_sessionManager GET:url.absoluteString
                                              parameters:dic
                                                progress:nil
                                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"请求成功：%@",str);
        [[self allSessionTask] removeObject:task];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 0) {
            NSDictionary *result = [resultDic objectForKey:@"result"];
            NSString *city = [result objectForKey:@"city"];
            NSString *temp = [result objectForKey:@"temp"];
            NSString *weat = [result objectForKey:@"weather"];
            NSString *desStr = [NSString stringWithFormat:@"%@℃ · %@ | %@", temp, weat, city];
            weatherData(desStr);
        }
        else if ([[resultDic objectForKey:@"status"] integerValue] == 202) {
            weatherData(@"--℃ · - | --");
        }
        else
        {
            weatherData(@"--℃ · - | --");
        }
    }
                                                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        weatherData(@"--℃ · - | --");
        [[self allSessionTask] removeObject:task];
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
}


#pragma mark  -----  getter

//  存储着所有的请求task数组
+ (NSMutableArray *)allSessionTask
{
    if (!_allSessionTask) {
        
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    
    return _allSessionTask;
}



@end
