//
//  ViewController.m
//  BUGTest
//
//  Created by Mac on 2018/5/8.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "WJTestDemo.h"
#import "WJLearnXIBViewController.h"
#import "WJNewbieGuideViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"能打印就说明正常：%d", [WJTestDemo string:@"1111111"]);
    [WJTestDemo errorStr];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //
    
    WJNewbieGuideViewController *vc = [[WJNewbieGuideViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
}

//  网址转码
- (void)transcodeURL
{
    NSString *url = @"秦文杰";
    
    NSString *two_trans_str = [WJStringHelper transcodeHTTPRealUrl:url];
    NSString *ios_9_trans   = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if ([two_trans_str isEqualToString:ios_9_trans]) {
        NSLog(@"一样的！！！被转码成：%@", ios_9_trans);
    }
    else
    {
        NSLog(@"两次转码获取到的URL：%@", two_trans_str);
        NSLog(@"使用iOS 9之后的方法转码：%@", ios_9_trans);
    }
}

//  奇葩空格符的BUG
- (void)errorStr
{
    NSString *str_0 = @"F S ";  // 未知状态下
    NSString *str_1 = @"F S ";  // 英文状态下
    
    if ([str_0 isEqualToString:str_1]) {
        NSLog(@"是一样的啊！！！");
    }
    else
    {
        NSLog(@"是不一样的！！！");
        NSLog(@"str_0 --- %@", [str_0 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]);
        NSLog(@"str_1 --- %@", [str_1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated. 
}


@end
