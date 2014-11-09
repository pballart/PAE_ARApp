//
//  League.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 9/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "League.h"

@implementation League

-(id)initLeagueWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if(self) {
        self.name = [dictionary objectForKey:@"name"];
        self.leagueId = [dictionary objectForKey:@"id"];
        self.minPoints = [dictionary objectForKey:@"minPoints"];
    }
    return self;
}

@end
