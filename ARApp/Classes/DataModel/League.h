//
//  League.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 9/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface League : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *leagueId;
@property (nonatomic, strong) NSNumber *minPoints;

-(id)initLeagueWithDictionary:(NSDictionary *)dictionary;

@end
