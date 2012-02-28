//
//  SvcTable.h
//  avtofon
//
//  Created by вадим on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SvcTable : UITableViewController

- (void)refresh: (BOOL)hand;
- (void)addPreloadedSvcs;
- (BOOL)addSvcs: (NSString*) url;

@end
