//
//  MarkModels.m
//  avtofon
//
//  Created by вадим on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MarkModels.h"
#import "Model.h"
#import "ModelComplectations.h"
#import "ModelCell.h"
#import "Common.h"
#import "UsedCellOne.h"
#import "Complectation.h"
#import "Service.h"

@implementation MarkModels

@synthesize mark = _mark;
@synthesize typeView;

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
    
    self.navigationItem.title = @"Модели";
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!typeView) 
        return 88;
    else
        return 43;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

 //   NSLog(@"models count = %d",  [self.mark.models count]);
    if (typeView == 2) 
       return [self.mark.services count]; 
    
    return [self.mark.models count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!typeView) {
        static NSString *CellIdentifier = @"ModelCell";
        
        ModelCell *cell = (ModelCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            // NSLog(@"NewsCell is nil");
            NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ModelCell" owner:nil options:nil];
            for (id currentObject in topLevelObjects) {
                
                if ([currentObject isKindOfClass:[ModelCell class]]) {
                    
                    cell = (ModelCell*) currentObject;
                    break;
                }
            }
        }
        
        Model* md = [self.mark.models objectAtIndex:indexPath.row];
        ((ModelCell*)cell).title.text = md.title;
        
        //    ((ModelCell*)cell).imageview.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: md.image]]];
        cell.imageView.image = [[Common instance] getImage:md.image];   
        return cell;
    }else if(typeView == 1){
        static NSString *CellIdentifier = @"UsedCellOne";
        
        UsedCellOne *cell = (UsedCellOne*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"UsedCellOne" owner:nil options:nil];
            for (id currentObject in topLevelObjects) {
                if ([currentObject isKindOfClass:[UsedCellOne class]]) {
                    cell = (UsedCellOne*) currentObject;
                    break;
                }
            }
        }
        // Configure the cell...
        Model* md = [self.mark.models objectAtIndex:indexPath.row];
        
        ((UsedCellOne*)cell).title.text = md.title;
        ((UsedCellOne*)cell).count.text = [NSString stringWithFormat:@"%d", [self.mark.models count]];
        NSMutableArray * array = md.complectations;
        if ([array count] > 0){ 
            NSString * price = nil;
            for (Complectation * item in array) {
                if (price == nil || [price intValue] < [[item price] intValue]) {
                    price = [item price];
                }
            }
            ((UsedCellOne*)cell).price.text = [NSString stringWithFormat:@"от %@ руб.", price] ;
        }else{
            ((UsedCellOne*)cell).price.text = @"";
        }
        
        return cell;
    }else if(typeView == 2){
        self.navigationItem.title = self.mark.title;
        static NSString *CellIdentifier = @"UsedCellOne";
        
        UsedCellOne *cell = (UsedCellOne*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"UsedCellOne" owner:nil options:nil];
            for (id currentObject in topLevelObjects) {
                if ([currentObject isKindOfClass:[UsedCellOne class]]) {
                    cell = (UsedCellOne*) currentObject;
                    break;
                }
            }
        }
        Service* srv = [self.mark.services objectAtIndex:indexPath.row];
        
        cell.title.text = srv.title;
        cell.price.text = srv.address;
        cell.count.text = @"";
        return cell;
    }else{
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        return cell;
    }
    
  /*  static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    Model* md = [self.mark.models objectAtIndex:indexPath.row];
    cell.textLabel.text = md.title;
    */
    
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ModelComplectations *detailViewController = [[ModelComplectations alloc] initWithNibName:@"ModelComplectations" bundle:nil];
    
    Model* md = [self.mark.models objectAtIndex:indexPath.row];
    
    detailViewController.model = md;
    if(typeView == 1)
        detailViewController.typeView = typeView;
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

@end
