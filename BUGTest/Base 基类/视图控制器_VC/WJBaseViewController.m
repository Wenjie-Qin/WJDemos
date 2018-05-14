//
//  WJBaseViewController.m
//  JDZS
//
//  Created by Mac on 2018/3/23.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "WJBaseViewController.h"


@interface WJBaseViewController ()

@property (nonatomic, retain)UIView         *placeholderView;

@end

@implementation WJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



#pragma mark  -----  整个VC无数据占位视图

- (void)addEmptyView:(UIImage *)image title:(NSString *)title
{
//    [self.view addSubview:self.placeholderView];
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.image = image;
//    [self.placeholderView addSubview:imageView];
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.font      = FONT_15_AU;
//    label.textColor = WJ_RGB_H(0xc8c8c8);
//    label.text      = title;
//    label.textAlignment = NSTextAlignmentCenter;
//    [self.placeholderView addSubview:label];
//    
//    [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(f_Device_w, W_i6real(160)));
//        make.centerX.equalTo(self.placeholderView);
//        make.top.offset(W_i6real(160));
//    }];
//    
//    [label mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(f_Device_w-W_i6real(13)*2, W_i6real(20)));
//        make.centerX.equalTo(self.placeholderView);
//        make.top.equalTo(imageView.mas_bottom).with.offset(W_i6real(41));
//    }];

}

- (void)removeEmptyView
{
    [self.placeholderView removeFromSuperview];
}


#pragma mark  -----  getter

- (UIView *)placeholderView
{
    if (!_placeholderView) {
        
        _placeholderView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    
    return _placeholderView;
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
