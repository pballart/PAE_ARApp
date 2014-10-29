//
//  Beer.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 29/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "Beer.h"

@implementation Beer

-(id)initBeerWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if(self) {
        self.name = [dictionary objectForKey:@"name"];
        self.beerId = [dictionary objectForKey:@"id"];
        self.beerInfo = [dictionary objectForKey:@"info"];
        self.beerImageURL = [dictionary objectForKey:@"img"];
        self.ownerId = nil;
        self.beerPoints = nil;
        self.brandId = [dictionary objectForKey:@"brand_id"];
        self.brandInfo = [dictionary objectForKey:@"brand_information"];
    }
    return self;
}
@end
