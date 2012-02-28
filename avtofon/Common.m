//
//  Common.m
//
//  Created by вадим on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Common.h"

@implementation UINavigationBar (UINavigationBarCategory)

-(void)setBackgroundImage:(UIImage*)image{
    
    if(image == NULL){ 

        [[Common instance].aTabBarBackground removeFromSuperview];
        return;
    }

    [Common instance].aTabBarBackground = [[UIImageView alloc]initWithImage:image];
    [Common instance].aTabBarBackground.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
    [self addSubview:[Common instance].aTabBarBackground];
    [self sendSubviewToBack:[Common instance].aTabBarBackground];

}

@end

@implementation Common

@synthesize dealerFilePath = _dealerFilePath;
@synthesize priceFilePath = _priceFilePath;
@synthesize creamFilePath = _creamFilePath;
@synthesize svcFilePath = _svcFilePath;
@synthesize usedFilePath = _usedFilePath;
@synthesize serviceFilePath = _serviceFilePath;
@synthesize aTabBarBackground = _aTabBarBackground;
@synthesize docpath = _docpath;

+ (Common*) instance  {
	
	static Common* instance;
	
	@synchronized(self) {
		
		if(!instance) {
			
			instance = [[Common alloc] init];
		}
	}
	return instance;
}

- (void) saveImage: (NSString*)path name:(NSString*)name {
    
    NSLog(@"saveImage: %@",name);
    NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@", self.docpath, name];
    if ([[NSFileManager defaultManager]fileExistsAtPath:pngFilePath])
        return;

    UIImage* img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: path]]];
    NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(img)];
    [data1 writeToFile:pngFilePath atomically:YES];
    
}

- (UIImage*) getImage: (NSString*)name {

    NSLog(@"getImage: %@",name);
    NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@", self.docpath, name];
    return [UIImage imageWithData:[NSData dataWithContentsOfFile:pngFilePath]];
}

- (id) init {	
	
	self = [super init];
	if(self !=nil) {
        
        dealers = [[NSMutableArray alloc] init];
        prices = [[NSMutableArray alloc] init];
        creams = [[NSMutableArray alloc] init];
        svcs = [[NSMutableArray alloc] init];
        useds = [[NSMutableArray alloc] init];
        services = [[NSMutableArray alloc] init];
        
 		NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		self.docpath = [sp objectAtIndex: 0];
        
        self.dealerFilePath = [self.docpath stringByAppendingPathComponent:@"dealers.plist"];
		BOOL fe = [[NSFileManager defaultManager] fileExistsAtPath:self.dealerFilePath];
		if(!fe) {
            
            NSLog(@"NO dealers.plist FILE !!! Creating...");
            NSString *appFile = [[NSBundle mainBundle] pathForResource:@"dealers" ofType:@"plist"];
			NSError *error;
			NSFileManager *fileManager = [NSFileManager defaultManager];
			[fileManager copyItemAtPath:appFile toPath:self.dealerFilePath error:&error];
			
		}
        dealer_file = [[NSMutableDictionary alloc] initWithContentsOfFile:self.dealerFilePath];

        
        self.priceFilePath = [self.docpath stringByAppendingPathComponent:@"prices.plist"];		
        fe = [[NSFileManager defaultManager] fileExistsAtPath:self.priceFilePath];
		if(!fe) {
            
            NSLog(@"NO prices.plist FILE !!! Creating...");
            NSString *appFile = [[NSBundle mainBundle] pathForResource:@"prices" ofType:@"plist"];
			NSError *error;
			NSFileManager *fileManager = [NSFileManager defaultManager];
			[fileManager copyItemAtPath:appFile toPath:self.priceFilePath error:&error];
			
		}
        price_file = [[NSMutableDictionary alloc] initWithContentsOfFile:self.priceFilePath];

        self.creamFilePath = [self.docpath stringByAppendingPathComponent:@"creams.plist"];		
        fe = [[NSFileManager defaultManager] fileExistsAtPath:self.creamFilePath];
		if(!fe) {
            
            NSLog(@"NO creams.plist FILE !!! Creating...");
            NSString *appFile = [[NSBundle mainBundle] pathForResource:@"creams" ofType:@"plist"];
			NSError *error;
			NSFileManager *fileManager = [NSFileManager defaultManager];
			[fileManager copyItemAtPath:appFile toPath:self.creamFilePath error:&error];
			
		}
        cream_file = [[NSMutableDictionary alloc] initWithContentsOfFile:self.creamFilePath];

        self.svcFilePath = [self.docpath stringByAppendingPathComponent:@"svcs.plist"];
		fe = [[NSFileManager defaultManager] fileExistsAtPath:self.svcFilePath];
		if(!fe) {
            
            NSLog(@"NO svc.plist FILE !!! Creating...");
            NSString *appFile = [[NSBundle mainBundle] pathForResource:@"svcs" ofType:@"plist"];
			NSError *error;
			NSFileManager *fileManager = [NSFileManager defaultManager];
			[fileManager copyItemAtPath:appFile toPath:self.svcFilePath error:&error];
			
		}
        svc_file = [[NSMutableDictionary alloc] initWithContentsOfFile:self.svcFilePath];
        
        self.usedFilePath = [self.docpath stringByAppendingPathComponent:@"useds.plist"];
		fe = [[NSFileManager defaultManager] fileExistsAtPath:self.usedFilePath];
		if(!fe) {
            
            NSLog(@"NO useds.plist FILE !!! Creating...");
            NSString *appFile = [[NSBundle mainBundle] pathForResource:@"useds" ofType:@"plist"];
			NSError *error;
			NSFileManager *fileManager = [NSFileManager defaultManager];
			[fileManager copyItemAtPath:appFile toPath:self.usedFilePath error:&error];
			
		}
        used_file = [[NSMutableDictionary alloc] initWithContentsOfFile:self.usedFilePath];
        
        self.serviceFilePath = [self.docpath stringByAppendingPathComponent:@"services.plist"];
		fe = [[NSFileManager defaultManager] fileExistsAtPath:self.serviceFilePath];
		if(!fe) {
            
            NSLog(@"NO services.plist FILE !!! Creating...");
            NSString *appFile = [[NSBundle mainBundle] pathForResource:@"services" ofType:@"plist"];
			NSError *error;
			NSFileManager *fileManager = [NSFileManager defaultManager];
			[fileManager copyItemAtPath:appFile toPath:self.serviceFilePath error:&error];
			
		}
        service_file = [[NSMutableDictionary alloc] initWithContentsOfFile:self.serviceFilePath];
	}
	return self;	
}

- (void) dealloc {
    
	[dealers release];
    [prices release];
    [creams release];
    [svcs release];
    [useds release];
    [services release];
    
    [_dealerFilePath release];
    [_priceFilePath release];
    [_creamFilePath release];
    [_aTabBarBackground release];
    [_svcFilePath release];
    [_usedFilePath release];
    [_serviceFilePath release];
    
    [_docpath release];
    
	[super dealloc];
}



- (void)clearMarkWsDealers {
    
    [dealers removeAllObjects];
}

- (void)addMarkWsDealer: (Mark*)item {
   
    [dealers addObject:item];
    NSLog(@"Dealer added, title: %@", item.title);
}

- (int) getMarkWsDealersCount {

    return [dealers count];
}

- (Mark*) getMarkWsDealerAt: (int)num {
    
    return [dealers objectAtIndex:num];
}


- (void)clearMarkWsPrices {
    
    [prices removeAllObjects];
}
- (void)addMarkWsPrice: (Mark*)item {
    
    [prices addObject:item];
    NSLog(@"Price added, title: %@", item.title);
}

- (int) getMarkWsPricesCount {
    
    return [prices count];
}

- (Mark*) getMarkWsPriceAt: (int)num {
    
    return [prices objectAtIndex:num];
}

- (void)clearMarkWsCreams {
    
    [creams removeAllObjects];
}

- (void)addMarkWsCream: (Mark*)item {
    
    [creams addObject:item];
    NSLog(@"Cream added, title: %@", item.title);
}

- (int) getMarkWsCreamsCount {
    
    return [creams count];
}

- (Mark*) getMarkWsCreamAt: (int)num {
    
    return [creams objectAtIndex:num];
}


- (void)clearMarkWsSvcs {
    [svcs removeAllObjects];
}

- (void)addMarkWsSvc: (Mark*)item {
    [svcs addObject:item];
    NSLog(@"Svc added, title: %@", item.title);
}

- (int) getMarkWsSvcsCount {
    
    return [svcs count];
}

- (Mark*) getMarkWsSvcAt: (int)num {
    
    return [svcs objectAtIndex:num];
}



- (void)clearMarkWsUseds {
    [useds removeAllObjects];
}

- (void)addMarkWsUsed: (Mark*)item {
    [useds addObject:item];
    NSLog(@"Used added, title: %@", item.title);
}

- (int) getMarkWsUsedsCount {
    
    return [useds count];
}

- (Mark*) getMarkWsUsedAt: (int)num {
    
    return [useds objectAtIndex:num];
}


- (void)clearMarkWsServices {
    [services removeAllObjects];
}

- (void)addMarkWsService: (Mark*)item {
    [services addObject:item];
    NSLog(@"Service added, title: %@", item.title);
}

- (int) getMarkWsServicesCount {
    return [services count];
}

- (Mark*) getMarkWsServiceAt: (int)num {
    return [services objectAtIndex:num];
}


- (BOOL) isOnlyWiFi {
    
	return [[NSUserDefaults standardUserDefaults] boolForKey:@"onlyWiFi"];
}

- (void) setOnlyWiFi: (BOOL)b {
	
	[[NSUserDefaults standardUserDefaults] setBool:b forKey:@"onlyWiFi"];
    
}

- (void) saveDealersPreload {
    
}

- (void) savePricesPreload {
    
}

- (void) saveCreamsPreload {
    
}

- (void) saveSvcsPreload {
    
}
- (void) saveUsedsPreload {
    
}
- (void) saveServicesPreload {
    
}

@end
