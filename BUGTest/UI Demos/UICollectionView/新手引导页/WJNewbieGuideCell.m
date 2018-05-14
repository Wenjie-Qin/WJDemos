//
//  WJNewbieGuideCell.m
//  BUGTest
//
//  Created by Mac on 2018/5/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "WJNewbieGuideCell.h"

@interface WJNewbieGuideCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgIcon;
@property (weak, nonatomic) IBOutlet UIButton *beginPlay;

@end

@implementation WJNewbieGuideCell

- (IBAction)beginClick:(UIButton *)sender {
    
    
}

- (void)setBgImage:(UIImage *)bgImage
{
    _bgImage = bgImage;
    self.bgIcon.image = bgImage;
}

-(void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count
{
    self.beginPlay.hidden = indexPath.item==count-1 ? NO : YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
