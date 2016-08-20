//
//  WatchSelectOfferTableViewCell.m
//  tiantianzhibo
//
//  Created by michael on 13/8/2016.
//  Copyright © 2016 michael. All rights reserved.
//

#import "WatchSelectOfferTableViewCell.h"
 
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width

@implementation WatchSelectOfferTableViewCell

 

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    /* [_offerImageView setTag:2];

    _offerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
    [_offerImageView addGestureRecognizer:singleTap];
    
    */
    
    
}


/*
- (IBAction)clickx:(id)sender,UITapGestureRecognizer *gesture{
   // UIView *temView = [gesture view];
   // NSInteger temIndex = temView.tag;
    NSLog(@"here cell");
}*/

/*
- (IBAction)tapImageView:(id)sender{
    // NSInteger temIndex = temView.tag;
    NSLog(@"here cell 3 %d", _offerImageView.tag);
    
    
    
}
 
 */




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
