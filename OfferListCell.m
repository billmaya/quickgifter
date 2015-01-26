//
//  OfferListCell.m
//  QuickGifter
//
//  Created by Bill Maya on 10/3/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "OfferListCell.h"


@implementation OfferListCell

@synthesize offerIcon, offerTitle;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
