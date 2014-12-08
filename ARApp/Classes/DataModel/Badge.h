//
//  Badge.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 7/12/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Badge : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *badgeId;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *achievedTimes;

-(id)initBadgeWithDictionary:(NSDictionary *)dictionary;
@end
