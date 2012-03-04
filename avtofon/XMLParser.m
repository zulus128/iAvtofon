//
//  XMLParser.m
//  XMLpars
//
//  Created by вадим on 2/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"
#import "Common.h"

enum type {
    
    EN_MARK,
    EN_DEALER,
    EN_MODEL,
    EN_COMLECTATION,
    EN_SERVICE
    
};

@implementation XMLParser

@synthesize item, dealer, model, complectation, service;

- (XMLParser *) initXMLParser: (int) type {
	
	[super init];
    
    itype = type;
    
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict {
	
    //  NSLog(@"Start Element");
    
	if([elementName isEqualToString:ITEM_TAG] || [elementName isEqualToString:CATEGORY_TAG]) {
        
		item = [[Mark alloc] init];
        //item.type = itype;
        //isDealer = NO;
        currtype = EN_MARK;
        
        NSLog(@"Item alloc type = %i", itype);
	}
	
    if([elementName isEqualToString:DEALER_TAG]) {
        
		dealer = [[Dealer alloc] init];
        //isDealer = YES;
        currtype = EN_DEALER;
	}	
    
    if([elementName isEqualToString:MODEL_TAG]) {
        
		model = [[Model alloc] init];
        currtype = EN_MODEL;
        
        //    NSLog(@"Model alloc");
	}	
    if([elementName isEqualToString:SERVICE_TAG]) {
        
		service = [[Service alloc] init];
        currtype = EN_SERVICE;
        
        //    NSLog(@"Model alloc");
	}
    
    if([elementName isEqualToString:COMPLECT_TAG] || [elementName isEqualToString:COMPLECTATION_TAG]) {
        
		complectation = [[Complectation alloc] init];
        currtype = EN_COMLECTATION;
	}	
    
    //   if ([elementName isEqualToString:IMAGE_TAG])
    //       item.image = [attributeDict objectForKey:@"url"];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	if(!currentElementValue)
		currentElementValue = [[NSMutableString alloc] initWithString:string];
	else
		[currentElementValue appendString:string];
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
	NSString* trimedStr;
	if(currentElementValue)
		trimedStr = [currentElementValue stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if([elementName isEqualToString:ITEM_TAG] || [elementName isEqualToString:CATEGORY_TAG] ) {
        
        switch (itype) {
            case TYPE_DEALER:
                [[Common instance] addMarkWsDealer:item];                
                break;
            case TYPE_COMPLECTATION:
                [[Common instance] addMarkWsPrice:item];                
                break;
            case TYPE_CREAM:
                [[Common instance] addMarkWsCream:item];                
                break;
            case TYPE_SVC:
                [[Common instance] addMarkWsSvc:item];                
                break;
            case TYPE_USED:
                [[Common instance] addMarkWsUsed:item];                
                break;
            case TYPE_SERVICE:
                [[Common instance] addMarkWsService:item];                
                break;
            default:
                break;
        }
        [item release];
    }
    else
        if([elementName isEqualToString:DEALER_TAG]) {
            
            [item.dealers addObject:dealer];
            [dealer release];
        }	        
        else
            if([elementName isEqualToString:COMPLECT_TAG] || [elementName isEqualToString:COMPLECTATION_TAG]) {
                
                [model.complectations addObject:complectation];
                // NSLog(@"addComplectation");
                [complectation release];
            }	        
            else
                if([elementName isEqualToString:SERVICE_TAG]) {
                    
                    [item.services addObject:service];
                    //  NSLog(@"addService");
                    [service release];
                }	        
                else
                if([elementName isEqualToString:MODEL_TAG]) {
                    
                    [item.models addObject:model];
                    //  NSLog(@"addModel");
                    [model release];
                }	        
                else
                    
                    if([elementName isEqualToString:TITLE_TAG]) {
                        
                        switch(currtype) {
                                
                            case EN_MARK:
                                item.title = trimedStr;
                                break;
                            case EN_DEALER:
                                dealer.title = trimedStr;
                                break;
                            case EN_MODEL:
                                model.title = trimedStr;
                                break;
                            case EN_COMLECTATION:
                                complectation.title = trimedStr;
                                break;
                            case EN_SERVICE:
                                service.title = trimedStr;
                                break;
                        }
                    }
                    else
                        if([elementName isEqualToString:IMAGE_TAG]) {
                            
                            NSString* nm = [trimedStr lastPathComponent];
//                            [[Common instance] saveImage:trimedStr name:nm];
                            switch(currtype) {
                                    
                                case EN_MARK:
                                    item.image = nm;
                                    break;
                                case EN_MODEL:
                                    model.image = nm;
                                    break;
                            }
                        }
                        else

                            if(dealer && [elementName isEqualToString:ADDRESS_TAG]) 
                                dealer.address = trimedStr;
                            else
                                if([elementName isEqualToString:CODE_TAG]) {
                                    
                                    switch(currtype) {
                                            
                                        case EN_DEALER:
                                            dealer.code = trimedStr;
                                            break;
                                        case EN_COMLECTATION:
                                            complectation.code = trimedStr;
                                            break;
                                        case EN_SERVICE:
                                            service.code = trimedStr;
                                            break;
                                    }
                                    
                                }else
                                    if(service && [elementName isEqualToString:TITLE_TAG]) 
                                        service.title = trimedStr;
                                    else
                                        if(service && [elementName isEqualToString:ADDRESS_TAG]) 
                                            service.address = trimedStr;
                                        else
                                            if(service && [elementName isEqualToString:PROMOTION_TAG]) 
                                                    service.promotion = trimedStr;
                                                else
                                                    if(service && [elementName isEqualToString:RECOMMEND_TAG]) 
                                                        service.recommend = trimedStr;
                                                    else
                                                    
                                    if(dealer && [elementName isEqualToString:PROMOTION_TAG]) 
                                        dealer.promotion = trimedStr;
                                    else
                                        if(dealer && [elementName isEqualToString:RECOMMEND_TAG]) 
                                            dealer.recommend = [trimedStr boolValue];
                                        else
                                            if(dealer && [elementName isEqualToString:RECOMMEND_TAG]) 
                                                dealer.recommend = [trimedStr boolValue];
                                            else
                                                if([elementName isEqualToString:YEAR_TAG]) 
                                                    complectation.year = trimedStr;
                                                else
                                                    if([elementName isEqualToString:VOLUME_TAG]) 
                                                        complectation.volume = trimedStr;
                                                    else
                                                        if([elementName isEqualToString:POWER_TAG]) 
                                                            complectation.power = trimedStr;
                                                        else
                                                            if([elementName isEqualToString:FUEL_TAG]) 
                                                                complectation.fuel = trimedStr;
                                                            else
                                                                if([elementName isEqualToString:TRANSMISSION_TAG]) 
                                                                    complectation.transmission = trimedStr;
                                                                else
                                                                    if([elementName isEqualToString:GEARBOX_TAG]) 
                                                                        complectation.gearbox = trimedStr;
                                                                    else
                                                                        if([elementName isEqualToString:PRICE_TAG]) 
                                                                            complectation.price = trimedStr;
                                                                        else
                                                                            if([elementName isEqualToString:PRICESPEC_TAG]) 
                                                                                complectation.pricespec = trimedStr;
                                                                            else
                                                                                if([elementName isEqualToString:RUN_TAG]) 
                                                                                    complectation.run = trimedStr;
                                                                                else
                                                                                    if([elementName isEqualToString:COLOR_TAG]) 
                                                                                        complectation.color = trimedStr;
    
    
	[currentElementValue release];
	currentElementValue = nil;
    
}

- (void) dealloc {
    
	//[item release];
	
	[currentElementValue release];
	[super dealloc];
}

@end
