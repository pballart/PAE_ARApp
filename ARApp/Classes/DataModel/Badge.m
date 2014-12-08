//
//  Badge.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 7/12/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "Badge.h"

@implementation Badge

-(id)initBadgeWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if(self) {
        self.name = [dictionary objectForKey:@"name"];
        self.badgeId = [dictionary objectForKey:@"id"];
        self.image = [dictionary objectForKey:@"img"];
        self.info = [dictionary objectForKey:@"info"];
        self.achievedTimes = [dictionary objectForKey:@"achieved"];
    }
    return self;
}
@end
