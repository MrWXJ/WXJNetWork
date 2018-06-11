//
//  ViewController.m
//  WXJNetWork
//
//  Created by MrWXJ on 2018/6/11.
//  Copyright © 2018年 MrWXJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *WXJNetworkOfMethod 为GET（1）、POST（2）
     *url 请求地址
     *parameter 请求参数
     */
    [[WXJNetwork network] WXJNetworkOfMethod:1 url:@"http://www.test.com" parameter:@"" cookieBool:false returnData:^(id data, NSError *error) {
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
