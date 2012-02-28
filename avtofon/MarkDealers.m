//
//  MarkDealers.m
//  avtofon
//
//  Created by naceka on 23.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MarkDealers.h"
#import "Dealer.h"
#import "Common.h"
#import "DealerCell.h"

@implementation MarkDealers

@synthesize mark = _mark;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
    
    [_mark release];

    [super dealloc];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.navigationController.navigationBar setBackgroundImage:NULL];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.mark.dealers count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
/*    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
  */  
    static NSString *CellIdentifier = @"DealerCell";
    
    DealerCell *cell = (DealerCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DealerCell" owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            
            if ([currentObject isKindOfClass:[DealerCell class]]) {
                
                cell = (DealerCell*) currentObject;
                break;
            }
        }
    }

    Dealer* dil = [self.mark.dealers objectAtIndex:indexPath.row];
//    cell.textLabel.text = dil.title;
//    cell.detailTextLabel.text = dil.address;
    cell.title.text = dil.title;
    cell.subtitle.text = dil.address;
    cell.recomend.text = dil.recommend?@"КАСКО":@"";
    //NSLog(@"title = %@", dil.title);
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    NSLog(@"Call...");
    [self dialNumber: indexPath.row];
    //Dealer* dil = [self.mark.dealers objectAtIndex:indexPath.row];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:87273216555,71"]];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:88001001808,%@",dil.code]]];
    /*
    UIWebView *myWebView=[[UIWebView alloc]initWithFrame:CGRectMake(20,20,200,300)];
    myWebView.backgroundColor = [UIColor whiteColor];
    myWebView.scalesPageToFit = YES;
    myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight);
    myWebView.delegate = self;
    
    NSString* telnumber = @"tel:+77273216555";
    NSString* extension = @"71";
    NSString *requestString; 
    if( extension == (id)[NSNull null] || extension.length == 0 )
        requestString = [NSString stringWithFormat:@"tel:%@",[telnumber stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    else requestString = [NSString stringWithFormat:@"tel:%@,,%@",[telnumber stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],extension];       
    [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestString]]];
     */
}

-(void) dialNumber:(int)n {
    
    Dealer* dil = [self.mark.dealers objectAtIndex:n];
    NSString *aPhoneNo = [NSString stringWithFormat:@"tel://88001001808,%@",dil.code];

    //NSString *aPhoneNo = [@"tel://" stringByAppendingString:[itsPhoneNoArray objectAtIndex:[sender tag]]];
    
    NSURL *url= [NSURL URLWithString:aPhoneNo];
    
    NSString *osVersion = [[UIDevice currentDevice] systemVersion];
    
    if ([osVersion floatValue] >= 3.1) { 
        UIWebView *webview = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame]; 
        [webview loadRequest:[NSURLRequest requestWithURL:url]]; 
        webview.hidden = YES; 
        // Assume we are in a view controller and have access to self.view 
        
        [self.view addSubview:webview]; 
        [webview release]; 
    
    } else { 
        
        // On 3.0 and below, dial as usual 
        [[UIApplication sharedApplication] openURL: url];
    }
    
    
}

@end
