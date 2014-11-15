//
//  RankingTVC.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 14/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Beer.h"
#import "User.h"

@interface RankingTVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *insigniaView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numGloopiesLabel;

-(void)configureCellWithBeer:(Beer *)beer;
-(void)configureCellWithUser:(User *)user;


@end
