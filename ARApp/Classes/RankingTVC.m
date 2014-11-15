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
    self.insigniaView.image = nil; //Chango for placeholder
}

-(void)configureCellWithBeer:(Beer *)beer {
    self.nameLabel.text = [beer.name uppercaseString];
    self.numGloopiesLabel.text = [NSString stringWithFormat:@"%@ G!", beer.beerPoints];
    NSURL *url = [NSURL URLWithString:[BASE_URL stringByAppendingPathComponent:beer.beerImageURL]]; //Add the placeholder
    [self.insigniaView setImageWithURL:url];
}

-(void)configureCellWithUser:(User *)user {
    self.nameLabel.text = [user.name uppercaseString];
    self.numGloopiesLabel.text = [NSString stringWithFormat:@"%@ G!", user.totalPoints];
    //Set image
}

@end
