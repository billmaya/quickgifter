//
//  OfferListCell.h
//  QuickGifter
//
//  Created by Bill Maya on 10/3/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OfferListCell : UITableViewCell {
	
	IBOutlet UIImageView *offerIcon;
	IBOutlet UILabel *offerTitle;
	
}

@property (nonatomic, retain) UIImageView *offerIcon;
@property (nonatomic, retain) UILabel *offerTitle;

@end
