//
//  SetupEditCell.m
//  QuickGifter
//
//  Created by Bill Maya on 8/14/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "SetupEditCell.h"


@implementation SetupEditCell

@synthesize textField;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Set the frame to CGRectZero as it will be reset in layoutSubviews
        textField = [[UITextField alloc] initWithFrame:CGRectZero];
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:32.0];
        textField.textColor = [UIColor blackColor];
		textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:textField];
    }
    return self;
}

- (void)dealloc {
    // Release allocated resources.
    [textField release];
    [super dealloc];
}

- (void)layoutSubviews {
    // Place the subviews appropriately.
    textField.frame = CGRectInset(self.contentView.bounds, 20, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Update text color so that it matches expected selection behavior.
    if (selected) {
        textField.textColor = [UIColor whiteColor];
    } else {
        textField.textColor = [UIColor blackColor];
    }
}



@end
