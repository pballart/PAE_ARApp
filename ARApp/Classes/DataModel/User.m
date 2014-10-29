//
//  User.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 29/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "User.h"
#import "Beer.h"


@implementation User

-(id)initUserWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if(self) {
        NSDictionary *userInfo = [dictionary objectForKey:@"user"];
        self.name = [userInfo objectForKey:@"userName"];
        self.userId = [userInfo objectForKey:@"id"];
        self.experiencePoints = [userInfo objectForKey:@"xp"];
        NSArray *beers = [userInfo objectForKey:@"birres"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *d in beers) {
            Beer *b = [[Beer alloc] initBeerWithDictionary:d];
            [array addObject:b];
        }
        self.scannedBeers = [array copy];
    }
    return self;
}

@end
