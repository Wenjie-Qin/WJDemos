//
//  WJBaseViewController.h
//  JDZS
//
//  Created by Mac on 2018/3/23.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EMPTY_SC_ICON          [UIImage imageNamed:@"mine_no_HEA_PL.jpg"]
#define EMPTY_CJ_ICON          [UIImage imageNamed:@"mine_no_HEA_PL.jpg"]

@interface WJBaseViewController : UIViewController

@property (nonatomic, retain)MBProgressHUD  *hud;

- (void)addEmptyView:(UIImage *)image title:(NSString *)title;
- (void)removeEmptyView;


@end
