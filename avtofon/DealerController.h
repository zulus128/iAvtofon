//
//  DealerController.h
//  avtofon
//
//  Created by вадим on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealerController : UIViewController

- (void)refresh: (BOOL)hand;
- (void)addPreloadedDealers;
- (BOOL)addDealers: (NSString*) url;

@property (nonatomic, retain) IBOutlet UITableView* tableView;

@end
