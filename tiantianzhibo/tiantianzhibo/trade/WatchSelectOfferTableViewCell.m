//
//  WatchSelectOfferTableViewCell.m
//  tiantianzhibo
//
//  Created by michael on 13/8/2016.
//  Copyright © 2016 michael. All rights reserved.
//

#import "WatchSelectOfferTableViewCell.h"
#import "OfferDetailMainViewController.h"


#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width

@implementation WatchSelectOfferTableViewCell

 

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
     [_offerImageView setTag:2];

    _offerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
    [_offerImageView addGestureRecognizer:singleTap];
    
    
    
    
}

- (UIViewController *)getParentViewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


/*
- (IBAction)clickx:(id)sender,UITapGestureRecognizer *gesture{
   // UIView *temView = [gesture view];
   // NSInteger temIndex = temView.tag;
    NSLog(@"here cell");
}*/


- (IBAction)tapImageView:(id)sender{
    // NSInteger temIndex = temView.tag;
    NSLog(@"here cell 3 %d", _offerImageView.tag);
    
    
         OfferDetailMainViewController  *offerDetailMainVc = [[OfferDetailMainViewController alloc] init];
        [[self getParentViewController] presentViewController:offerDetailMainVc animated:YES completion:nil];
        
    
 }
 





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
