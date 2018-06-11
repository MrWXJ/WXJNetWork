//
//  WXJNetwork.m
//  WXJ_All_Code
//
//  Created by WXJ on 2018/5/11.
//  Copyright © 2018年 WXJ. All rights reserved.
//

#import "WXJNetwork.h"

@interface WXJNetwork ()

@property (nonatomic, strong) ReturnData returnData;
@property (nonatomic, strong) ReturnCookie returnCookie;

@end

static WXJNetwork *_network = nil;

@implementation WXJNetwork

/**
 单例模式

 @return _network
 */
+ (WXJNetwork *)network {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _network = [[WXJNetwork alloc] init];
    });
    return _network;
}

/**
 网络请求

 @param method 请求方式
 @param url 请求网址
 @param parameter 请求参数
 @param cookieBool 是否需要cookie值
 @param returnData 返回data和error
 */
- (void)WXJNetworkOfMethod:(enum WXJHTTPMethod)method
                       url:(NSString *)url
                 parameter:(NSString *)parameter
                cookieBool:(BOOL)cookieBool
                returnData:(ReturnData)returnData {
    //1.初始化url
    NSURL *nsurl = [NSURL URLWithString:url];
    //2.初始化网络请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    //3.设置请求方式
    if (method == 1) {
        request.HTTPMethod = @"GET";
    } else {
        request.HTTPMethod = @"POST";
    }
    //4.请求超时
    request.timeoutInterval = 10;
    //5.判断是否需要cookie值
    if (cookieBool == YES) {
        NSString *cookie = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"]];
        [request setValue:cookie forHTTPHeaderField:@"cookie"];
    }
    //6.对参数进行UTF8编码
    NSData *data = [parameter dataUsingEncoding:NSUTF8StringEncoding];
    //7.设置请求体
    request.HTTPBody = data;
    //8.创建Session
    NSURLSession *session = [NSURLSession sharedSession];
    //9.请求SessionDataTask
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //1>请求无误
        if (error == nil) {
            //11.系列化接收请求下来的数据
            id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (self.returnData) {
                self.returnData(jsonObj, nil);
            }
        } else {
            //2>请求错误
            if (self.returnData) {
                self.returnData(nil, error);
            }
        }
    }];
    //12.执行网络任务
    [task resume];
    
}


@end
