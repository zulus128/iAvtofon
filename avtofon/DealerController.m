//
//  DealerController.m
//  avtofon
//
//  Created by вадим on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DealerController.h"
#import "Common.h"
#import "Reachability.h"
#import "XMLParser.h"
#import "CommonDealerCell.h"

@implementation DealerController

@synthesize tabView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self refresh:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view from its nib.
    
    [self refresh:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    
    self.tabView = nil;
    
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[Common instance] getMarkWsDealersCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CommonDealerCell";
    
//    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//    }
    
    CommonDealerCell* cell = (CommonDealerCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CommonDealerCell" owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [[cell lab1] setText:@"leftlabel"];
    [[cell lab2] setText:@"rightlabel"]; 
    
    // Configure the cell...
    Mark* mark = [[Common instance]getMarkWsDealerAt:indexPath.row];
    cell.textLabel.text = mark.title;
//    cell.imageView.image = [[Common instance] getImage:mark.image];
    
    return cell;
}

- (void)refresh: (BOOL)hand {
    
    NSLog(@"refresh dealers");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
	
    BOOL b = [[Reachability reachabilityWithHostName:MENU_URL_FOR_REACH] currentReachabilityStatus];    
    if (([[Common instance] isOnlyWiFi] && (b != ReachableViaWiFi))
        || (![[Common instance] isOnlyWiFi] && (b == NotReachable))) {
        
		UIAlertView* dialog = [[UIAlertView alloc] init];
		[dialog setTitle:@"Убедитесь в наличии Интернета!"];
		[dialog setMessage:@"Невозможно загрузить список."];
		[dialog addButtonWithTitle:@"OK"];
		[dialog show];
		[dialog release];
        
        [self addPreloadedDealers];
        
        /*        Item* item = [[Common instance] getsAt:0];
         self.topcell.title.text = item.title;
         self.topcell.rubric.text = item.rubric;
         self.topcell.image.image = [Common loadImage];
         [Common instance].img = self.topcell.image.image;
         */      
        [self.tabView reloadData];
		
	}else {
        
        [[Common instance] clearMarkWsDealers];
        if(![self addDealers:XMLDEALERS_URL]) {
            
            [self addPreloadedDealers];
            
            /* Item* item = [[Common instance] getNewsAt:0];
             self.topcell.title.text = item.title;
             self.topcell.rubric.text = item.rubric;
             self.topcell.image.image = [Common loadImage];
             [Common instance].img = self.topcell.image.image;
             */
            [self.tabView reloadData];
            hand = NO;
            
        }
        else {
            
            [self.tabView reloadData];
            [[Common instance] saveDealersPreload];
            
            if([[Common instance] getMarkWsDealersCount]) {
                
                /*      
                 Item* item = [[Common instance] getNewsAt:0];
                 self.topcell.title.text = item.title;
                 self.topcell.rubric.text = item.rubric;
                 self.topcell.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: item.image]]];
                 [Common instance].img = self.topcell.image.image;
                 
                 [Common saveImage:self.topcell.image.image];
                 */
            }
        }
    }
    
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void) addPreloadedDealers {
    
    //   [[Common instance] clearNews];
    //   [[Common instance] clearQAs];
    //   [[Common instance] clearPodcasts];
    
    //   [[Common instance] loadPreloaded];
}


- (BOOL)addDealers: (NSString*) url {
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:url]];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = nil;//[[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    //        [error release];
    if (responseData == nil) {
        // Check for problems
        if (error != nil) {
            
            UIAlertView* dialog = [[UIAlertView alloc] init];
            [dialog setTitle:@"Ошибка Интернет-подключения"];
            [dialog setMessage:[error localizedDescription]];
            [dialog addButtonWithTitle:@"OK"];
            [dialog show];
            [dialog release];
            return NO;
        }
    }
    NSString *myStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];// NSWindowsCP1251StringEncoding];
    //myStr = [myStr stringByReplacingOccurrencesOfString:@"encoding=\"windows-1251\"" withString:@""];
    NSData* aData = [myStr dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:aData];
    XMLParser* parser = [[XMLParser alloc] initXMLParser:TYPE_DEALER];
    [xmlParser setDelegate:parser];    
    
    for (int i = 0; i < 5; i++) {
        
        BOOL success = [xmlParser parse];	
        
        if(success) {
            
            NSLog(@"No Errors");
            //            [self.tableView reloadData];
            break;
        }
        else {
            
            //NSLog(@"Error! Possibly xml version is not new");
            NSLog(@"Parser error: %@", [[xmlParser parserError] localizedDescription]);
            return NO;
        }
    }
    
    return YES;
}

@end
