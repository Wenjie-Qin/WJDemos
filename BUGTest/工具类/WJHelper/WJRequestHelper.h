//
//  WJRequestHelper.h
//  JDZS
//
//  Created by Mac on 2018/3/28.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJRequestHelper : NSObject

//  取消所有HTTP请求
+ (void)cancelAllRequest;

//  取消指定URL的HTTP请求
+ (void)cancelRequestWithURL:(NSString *)URL;

/*  设置请求头
 *
 *  @param dic  A：dic   == nil  取消请求头
                B：count == 0    设置请求头
                C：count >  0    自定义请求头（暂不考虑）
 *
 *  return 无返回值
 */
+ (void)setHTTPHeaderFieldForDic:(NSDictionary *)dic;



/*  发送POST请求
 *
 *  @param URLString  用来拼接完整的url
 *  @param dic        参数字典
 *  @param success    请求成功(success)的回调，回传值为NSDictionary
 *  @param failure    请求成功(fail)的回调，回传值为NSDictionary
 *  @param errorBlock 请求失败的回调，回传值为NSError
 *
 *  return 无返回值
 */
+ (__kindof NSURLSessionTask *)postRequest:(NSString *)URLString
                                HTTPHeader:(NSDictionary *)HTTPHeader
                                parameters:(NSDictionary *)dic
                                   success:(void (^)(NSDictionary *successDict))success
                                   failure:(void (^)(NSDictionary *failDict))failure
                                errorBlock:(void (^)(NSError *error))errorBlock;


/*  发送GET请求
 *
 *  @param URLString  用来拼接完整的url
 *  @param dic        参数字典
 *  @param success    请求成功(success)的回调，回传值为NSDictionary
 *  @param failure    请求成功(fail)的回调，回传值为NSDictionary
 *  @param errorBlock 请求失败的回调，回传值为NSError
 *
 *  return 无返回值
 */
+ (__kindof NSURLSessionTask *)getRequest:(NSString *)URLString
                               HTTPHeader:(NSDictionary *)HTTPHeader
                               parameters:(NSDictionary *)dic
                                  success:(void (^)(NSDictionary *successDict))success
                                  failure:(void (^)(NSDictionary *failDict))failure
                               errorBlock:(void (^)(NSError *error))errorBlock;


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
                                        errorBlock:(void (^)(NSError *error))errorBlock;


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
                  weatherData:(void (^)(NSString *weatherDes))weatherData;


@end
