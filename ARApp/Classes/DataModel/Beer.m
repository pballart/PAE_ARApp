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
        NSAssert(self.name, @"Beer name is null");
        self.beerId = [dictionary objectForKey:@"id"];
        self.beerInfo = [dictionary objectForKey:@"info"];
        self.beerImageURL = [dictionary objectForKey:@"img"];
        self.beerBannerURL = [dictionary objectForKey:@"banner"];
        self.beerPoints = [dictionary objectForKey:@"points"];
        self.website = [dictionary objectForKey:@"website"];
        self.beerTotalChecks = [dictionary objectForKey:@"birraTotalChecks"];
    }
    return self;
}

@end
