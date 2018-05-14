//
//  WJLearnXIBView.m
//  BUGTest
//
//  Created by Mac on 2018/5/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "WJLearnXIBView.h"

@implementation WJLearnXIBView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"WJLearnXIBView" owner:self options:nil] firstObject];
        self.frame = frame;
    }
    
    return self;
}

@end
