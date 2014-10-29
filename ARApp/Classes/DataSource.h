//
//  DataSource.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 17/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"


@interface DataSource : NSObject

+ (DataSource *)sharedDataSource;

- (void)getBeerWithIdentifier:(NSString *)identifier
                completion:(void(^)(NSDictionary *dict, NSError *error))block;

- (void)logInWithEmail:(NSString *)email andPassword:(NSString*)password
            completion:(void(^)(User *user, NSError *error))block;

- (void)signInWithEmail:(NSString *)email name:(NSString*)name andPassword:(NSString*)password
             completion:(void(^)(NSDictionary *dict, NSError *error))block;

@end
