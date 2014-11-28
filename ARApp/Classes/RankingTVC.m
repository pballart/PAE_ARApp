//
//  RankingTVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 14/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "RankingTVC.h"
#import <Pods/UIImageView+AFNetworking.h>
#import "DataSource.h"

#define BASE_URL @"http://plusdimension.hol.es"

@implementation RankingTVC

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.nameLabel.text = @"";
    self.numGloopiesLabel.text = @"";
    [self.insigniaView setImage:[UIImage imageNamed:@"beerCellIcon"]];
    self.numPosLabel.text = @"";
    self.numPosLabel.hidden = NO;
}

-(void)configureCellWithBeer:(Beer *)beer {
    self.nameLabel.text = [beer.name uppercaseString];
    self.numGloopiesLabel.text = [NSString stringWithFormat:@"%@ G!", beer.beerTotalChecks];
}

-(void)configureCellWithUser:(User *)user {
    self.nameLabel.text = [user.name uppercaseString];
    self.numGloopiesLabel.text = [NSString stringWithFormat:@"%@ G!", user.totalPoints];
    //Set image
}
-(void)configureCellWithImageName:(NSString *)stringImage{
    [self.insigniaView setImage:[UIImage imageNamed:stringImage]];
}

-(void)configureCellWithNumberPos:(NSInteger)position{
    NSInteger pos = position+1;
    self.numPosLabel.text = [NSString stringWithFormat:@"%ld", (long)pos];
}
-(void)setToInvisible{
    self.numPosLabel.hidden = YES;
}

@end

