//
//  Common.h_
//  Created by вадим on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"

#define ITEM_TAG @"mark"
#define CATEGORY_TAG @"category"
#define SERVICE_TAG @"service"
#define TITLE_TAG @"title"
#define IMAGE_TAG @"img"
#define DEALER_TAG @"dealer"
#define ADDRESS_TAG @"adress"
#define CODE_TAG @"cod"
#define PROMOTION_TAG @"promotion"
#define RECOMMEND_TAG @"recommend"
#define MODEL_TAG @"model"
#define COMPLECT_TAG @"complect"
#define COMPLECTATION_TAG @"complectation"
#define YEAR_TAG @"year"
#define VOLUME_TAG @"volume"
#define POWER_TAG @"power"
#define FUEL_TAG @"fuel"
#define TRANSMISSION_TAG @"transmision"
#define GEARBOX_TAG @"gearbox"
#define PRICE_TAG @"price"
#define PRICESPEC_TAG @"pricespec"
#define RUN_TAG @"run"
#define COLOR_TAG @"color"

#define MENU_URL_FOR_REACH @"www.avtofon.com"
#define XMLDEALERS_URL @"http://avtofon.com/sheet/xmldealer"
#define XMLPRICES_URL @"http://avtofon.com/sheet/xmlprice"
#define XMLCREAMS_URL @"http://avtofon.com/sheet/xmlcream"



#define XML_USED_URL @"http://avtofon.com/sheet/xmlrun"
#define XML_SVC_URL @"http://avtofon.com/sheet/xmlsvc"
#define XML_SERVICES_URL @"http://avtofon.com/sheet/xmlservices"

enum item_types {
    
    TYPE_DEALER,
    TYPE_COMPLECTATION,
    TYPE_CREAM,
    TYPE_SVC,
    TYPE_USED,
    TYPE_SERVICE
};

@interface UINavigationBar (UINavigationBarCategory)
-(void) setBackgroundImage:(UIImage*)image;
@end

@interface Common : NSObject {
 
    NSMutableArray* dealers;
    NSMutableArray* prices;
    NSMutableArray* creams;
    NSMutableArray* svcs;
    NSMutableArray* useds;
    NSMutableArray* services;
    
    NSMutableDictionary* dealer_file;
    NSMutableDictionary* price_file;
    NSMutableDictionary* cream_file;
    NSMutableDictionary* svc_file;
    NSMutableDictionary* used_file;
    NSMutableDictionary* service_file;
    
}

@property (nonatomic, retain) NSString* dealerFilePath;
@property (nonatomic, retain) NSString* priceFilePath;
@property (nonatomic, retain) NSString* creamFilePath;
@property (nonatomic, retain) NSString* svcFilePath;
@property (nonatomic, retain) NSString* usedFilePath;
@property (nonatomic, retain) NSString* serviceFilePath;
@property (nonatomic, retain) UIImageView *aTabBarBackground;
@property (nonatomic, retain) NSString* docpath;

+ (Common*)instance;

- (void) saveImage: (NSString*)path name:(NSString*)name;
- (UIImage*) getImage: (NSString*)name;

- (void)clearMarkWsDealers;
- (void)addMarkWsDealer: (Mark*)item;
- (int) getMarkWsDealersCount;
- (Mark*) getMarkWsDealerAt: (int)num;

- (void)clearMarkWsPrices;
- (void)addMarkWsPrice: (Mark*)item;
- (int) getMarkWsPricesCount;
- (Mark*) getMarkWsPriceAt: (int)num;

- (void)clearMarkWsCreams;
- (void)addMarkWsCream: (Mark*)item;
- (int) getMarkWsCreamsCount;
- (Mark*) getMarkWsCreamAt: (int)num;

- (void)clearMarkWsSvcs;
- (void)addMarkWsSvc: (Mark*)item;
- (int) getMarkWsSvcsCount;
- (Mark*) getMarkWsSvcAt: (int)num;

- (void)clearMarkWsUseds;
- (void)addMarkWsUsed: (Mark*)item;
- (int) getMarkWsUsedsCount;
- (Mark*) getMarkWsUsedAt: (int)num;

- (void)clearMarkWsServices;
- (void)addMarkWsService: (Mark*)item;
- (int) getMarkWsServicesCount;
- (Mark*) getMarkWsServiceAt: (int)num;

- (BOOL) isOnlyWiFi;
- (void) setOnlyWiFi: (BOOL)b;

- (void) saveDealersPreload;
- (void) savePricesPreload;
- (void) saveCreamsPreload;
- (void) saveSvcsPreload;
- (void) saveUsedsPreload;
- (void) saveServicesPreload;

@end
