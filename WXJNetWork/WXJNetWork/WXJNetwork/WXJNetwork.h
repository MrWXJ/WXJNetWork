//
//  WXJNetwork.h
//  WXJ_All_Code
//
//  Created by WXJ on 2018/5/11.
//  Copyright © 2018年 WXJ. All rights reserved.
//

///-----------------------------------
/// 原生封装的网络请求
///-----------------------------------

#import <Foundation/Foundation.h>

/**
 返回数据data和error

 @param data 返回的数据
 @param error 错误描述
 */
typedef void(^ReturnData)(id data,NSError *error);

/**
 返回cookie

 @param cookie cookie值
 */
typedef void(^ReturnCookie)(NSMutableString *cookie);

/**
 类型枚举
 */
enum WXJHTTPMethod {
    methodOfGet = 1,//GET
    methodOfPost = 2,//POST
};

@interface WXJNetwork : NSObject

/**
 单例模式
 
 @return _network
 */
+ (WXJNetwork *)network;

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
                returnData:(ReturnData)returnData;

@end
