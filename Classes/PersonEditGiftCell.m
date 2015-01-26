//
//  PersonEditGiftCell.m
//  QuickGifter
//
//  Created by Bill Maya on 9/8/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "PersonEditGiftCell.h"


@implementation PersonEditGiftCell

@synthesize textField;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Set the frame to CGRectZero as it will be reset in layoutSubviews
        textField = [[UITextField alloc] initWithFrame:CGRectZero];
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:32.0];
        textField.textColor = [UIColor blackColor];
        [self addSubview:textField];
    }
    return self;
}

- (void)layoutSubviews {
    // Place the subviews appropriately.
    textField.frame = CGRectInset(self.contentView.bounds, 20, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}


- (void)dealloc {
	[textField release];
    [super dealloc];
}

@end
