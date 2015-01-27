//
//  PersonDetailGiftCell.m
//  QuickGifter
//
//  Created by Bill Maya on 9/8/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import "PersonDetailGiftCell.h"


@implementation PersonDetailGiftCell

@synthesize type, name, prompt, promptMode;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialize the labels, their fonts, colors, alignment, and background color.
        
		name = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 305, 35)];
        name.font = [UIFont boldSystemFontOfSize:14];
        name.backgroundColor = [UIColor clearColor];
		
        type = [[UILabel alloc] initWithFrame:CGRectMake(30, 22, 305, 20)];
		type.font = [UIFont boldSystemFontOfSize:12];
        type.textColor = [UIColor blackColor];
        type.backgroundColor = [UIColor clearColor];
		
		prompt = [[UILabel alloc] initWithFrame:CGRectMake(30, 111, 305, 35)];
        prompt.font = [UIFont boldSystemFontOfSize:14];
        prompt.textColor = [UIColor blackColor];
        prompt.backgroundColor = [UIColor clearColor];
        
        // Add the labels to the content view of the cell.
        
        // Important: although UITableViewCell inherits from UIView, you should add subviews to its content view
        // rather than directly to the cell so that they will be positioned appropriately as the cell transitions 
        // into and out of editing mode.
        
        [self.contentView addSubview:type];
        [self.contentView addSubview:name];
		[self.contentView addSubview:prompt];
		//        self.autoresizesSubviews = YES;
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

// Setting the prompt mode to YES hides the type/name labels and shows the prompt label.
- (void)setPromptMode:(BOOL)flag {
    if (flag) {
        type.hidden = YES;
        name.hidden = YES;
        prompt.hidden = NO;
    } else {
        type.hidden = NO;
        name.hidden = NO;
        prompt.hidden = YES;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    // Start with a rect that is inset from the content view by 10 pixels on all sides.
    CGRect baseRect = CGRectInset(self.contentView.bounds, 10, 10);
    CGRect rect = baseRect;
    rect.origin.x += 15;
	
    // Position each label with a modified version of the base rect.
    prompt.frame = rect;
    
	//rect.origin.x -= 15;
    //rect.size.width = 100;
    //type.frame = rect;
    
	//rect.origin.x += 110;
    //rect.size.width = baseRect.size.width - 70;
    //name.frame = rect;
}

@end
