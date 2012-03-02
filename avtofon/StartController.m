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
    
    UIFont* ffont = [UIFont fontWithName:@"Candara-Bold" size:18];
    
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(17, 105, 80, 20)];
    lab1.text = @"Дилеры";
    lab1.font = ffont;
    lab1.textColor = [UIColor colorWithRed:134.0/255.0 green:128.0/255.0 blue:188.0/255.0 alpha:1.0];
    [self.view addSubview:lab1];
    [lab1 release];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(140, 105, 60, 20)];
    lab2.text = @"Цены";
    lab2.font = ffont;
    lab2.textColor = [UIColor colorWithRed:134.0/255.0 green:128.0/255.0 blue:188.0/255.0 alpha:1.0];
    [self.view addSubview:lab2];
    [lab2 release];
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(240, 105, 90, 20)];
    lab3.text = @"Остатки";
    lab3.font = ffont;
    lab3.textColor = [UIColor colorWithRed:134.0/255.0 green:128.0/255.0 blue:188.0/255.0 alpha:1.0];
    [self.view addSubview:lab3];
    [lab3 release];

    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(17, 205, 80, 20)];
    lab4.text = @"С пробегом";
    lab4.font = ffont;
    lab4.textColor = [UIColor colorWithRed:134.0/255.0 green:128.0/255.0 blue:188.0/255.0 alpha:1.0];
    [self.view addSubview:lab4];
    [lab4 release];
    
    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(140, 205, 60, 20)];
    lab5.text = @"Сервис";
    lab5.font = ffont;
    lab5.textColor = [UIColor colorWithRed:134.0/255.0 green:128.0/255.0 blue:188.0/255.0 alpha:1.0];
    [self.view addSubview:lab5];
    [lab5 release];
    
    UILabel *lab6 = [[UILabel alloc] initWithFrame:CGRectMake(240, 205, 90, 20)];
    lab6.text = @"Услуги";
    lab6.font = ffont;
    lab6.textColor = [UIColor colorWithRed:134.0/255.0 green:128.0/255.0 blue:188.0/255.0 alpha:1.0];
    [self.view addSubview:lab6];
    [lab6 release];

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
