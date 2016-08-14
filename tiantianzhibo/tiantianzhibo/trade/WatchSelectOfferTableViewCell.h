//
//  WatchSelectOfferTableViewCell.h
//  tiantianzhibo
//
//  Created by michael on 13/8/2016.
//  Copyright © 2016 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchSelectOfferTableViewCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UIImageView *offerImageView;
@property (nonatomic, weak) IBOutlet UILabel *offerTitleLabel;

@property (nonatomic, weak) IBOutlet UILabel *offerPriceLabel;

@property (nonatomic, weak) IBOutlet UILabel *sellerShopNameLabel;


@property (nonatomic, weak) IBOutlet UIButton *buyOfferBtn;




@end
