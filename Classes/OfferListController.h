//
//  OfferListController.h
//  QuickGifter
//
//  Created by Bill Maya on 8/25/09.
//  Copyright 2009 Wampum & Womantam Creations. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OfferListController : UIViewController 
	<UITableViewDataSource, UITableViewDelegate> {

		NSArray *offers;
		UITableView *tableView;
}

@property (nonatomic, retain) NSArray *offers;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (IBAction)scale:(UIImage *)image toSize:(CGSize)size;

@end
