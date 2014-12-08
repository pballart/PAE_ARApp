//
//  User.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 29/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "League.h"

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *experiencePoints;
@property (nonatomic, strong) NSString *totalPoints;
@property (nonatomic, strong) NSArray *scannedBeers;
@property (nonatomic, strong) League *league;


-(id)initUserWithDictionary:(NSDictionary *)dictionary;
-(id)initUserWithRankingDictionary:(NSDictionary *)dictionary;

@end
