//
//  StartController.m
//  avtofon
//
//  Created by Mac on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StartController.h"
#import "Common.h"

@implementation StartController

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

//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setTintColor:[UIColor greenColor]];
//    
//}

//- (void)viewDidAppear:(BOOL)animated {
//    
//    [super viewDidAppear:animated];
//    
//    UIImage *image = [UIImage imageNamed: @"avtofon-green.png"];
//    [self.navigationController.navigationBar setBackgroundImage:image];
//}

-(IBAction) push1 {
    
    NSLog(@"push1");
    
//    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    delegate.tCtr.selectedIndex = 0;  //ur button tag;
//    delegate.tCtr.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentModalViewController:delegate.tCtr animated:YES];
    
//    UIApplication *myApplication = [UIApplication sharedApplication];
//    UIWindow *mainWindow = [myApplication keyWindow];
//    UIViewController *rootViewController = [mainWindow rootViewController];
}

@end
