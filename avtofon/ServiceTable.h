//
//  ServiceTable.h
//  avtofon
//
//  Created by вадим on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceTable : UITableViewController

- (void)refresh: (BOOL)hand;
- (void)addPreloadedServices;
- (BOOL)addServices: (NSString*) url;

@end
