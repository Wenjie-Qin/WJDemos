//
//  WJLearnXIBViewController.m
//  BUGTest
//
//  Created by Mac on 2018/5/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "WJLearnXIBViewController.h"

#import "WJLearnXIBView.h"

@interface WJLearnXIBViewController ()

@end

@implementation WJLearnXIBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WJLearnXIBView *xibView = [[WJLearnXIBView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    xibView.backgroundColor = [UIColor redColor];
    [self.view addSubview:xibView];
    
    NSLog(@"laoqinzuishuai");
    NSLog(@"版本一 增加一些东西");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
