//
//  OfferDetailMainTableViewCell.m
//  tiantianzhibo
//
//  Created by michael on 20/8/2016.
//  Copyright © 2016 michael. All rights reserved.
//

#import "OfferDetailMainTableViewCell.h"
#import "ScrollImageViewController.h"


#define ScreenH [UIScreen mainScreen].bounds.size.height

#define ScreenW [UIScreen mainScreen].bounds.size.width

@implementation OfferDetailMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    ScrollImageViewController  *scrollVc = [[ScrollImageViewController alloc] init];
    //2：这个很关键，增加子控制器，才能保证子页面的tableview在滑动时，不消失内容。这里是个坑。
   // [self addChildViewController:scrollVc];
    _myScrollView =   [scrollVc view];
    _myScrollView.frame = CGRectMake(0,0, ScreenW, 350);
    [_myOfferView addSubview:_myScrollView];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
