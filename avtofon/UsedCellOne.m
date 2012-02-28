//
//  UsedCellOne.m
//  avtofon
//
//  Created by вадим on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UsedCellOne.h"

@implementation UsedCellOne

@synthesize title, count, price;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
