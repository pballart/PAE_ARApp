//
//  DataSource.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 17/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString *API_BASE_URL;

@interface DataSource : NSObject

+ (DataSource *)sharedDataSource;

//Beer methods

- (void)getBeerWithIdentifier:(NSString *)identifier
                   completion:(void(^)(NSDictionary *dict, NSError *error))block;

- (void)getBeerFromCatchoomWithIdentifier:(NSString *)identifier
                               completion:(void(^)(NSDictionary *dict, NSError *error))block;

- (void)getInfoFromBeer:(NSString *)beerId
                andUser:(NSString *)userId
             completion:(void(^)(NSDictionary *dict, NSError *error))block;

- (void)getBeersFromUser:(NSString *)userId
              completion:(void(^)(NSDictionary *dict, NSError *error))block;

- (void)getOwnerInfoFromBeer:(NSString *)beerId
                   andLeague:(NSString *)leagueId
                  completion:(void(^)(NSDictionary *dict, NSError *error))block;

//Gloop!

- (void)updateBeer:(NSString *)beerId
          withUser:(NSString *)userId
        completion:(void(^)(NSDictionary *dict, NSError *error))block;

//Ranking methods

- (void)getRankingTotalWithcompletion:(void(^)(NSDictionary *dict, NSError *error))block;

- (void)getRankingDailyWithcompletion:(void(^)(NSDictionary *dict, NSError *error))block;

- (void)getRankingWeeklyWithcompletion:(void(^)(NSDictionary *dict, NSError *error))block;

- (void)getRankingTopTenUsersWithcompletion:(void(^)(NSDictionary *dict, NSError *error))block;

//User methods

- (void)getUserWithIdentifier:(NSString *)identifier
                   completion:(void(^)(NSDictionary *dict, NSError *error))block;

- (void)getLeagueInfoWithLeagueIdentifier:(NSString *)identifier
                               completion:(void(^)(NSDictionary *dict, NSError *error))block;

- (void)getBadgetWithUserIdentifier:(NSString *)identifier
                         completion:(void(^)(NSDictionary *dict, NSError *error))block;

- (void)logInWithEmail:(NSString *)email
           andPassword:(NSString*)password
            completion:(void(^)(NSDictionary *dict, NSError *error))block;

- (void)signInWithEmail:(NSString *)email
                   name:(NSString*)name
               birthday:(NSNumber *)birthday
                 gender:(NSNumber *)gender
            andPassword:(NSString*)password
             completion:(void(^)(NSDictionary *dict, NSError *error))block;

@end
