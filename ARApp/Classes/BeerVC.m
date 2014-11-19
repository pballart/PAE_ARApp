//
//  BeerVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 9/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "BeerVC.h"
#import "AppDelegate.h"
#import <Pods/UIImageView+AFNetworking.h>
#import "User.h"

#define BASE_URL @"http://plusdimension.hol.es"

const struct BeerParameters BeerParameters = {
    .ownerName = @"__OWNER_NAME__",
    .becomeOwner = @"__BECOME_OWNER__",
    .pointsMade = @"__POINTS_MADE__",
    .lastCheck = @"__LAST_CHECK__",
    .beerInfo = @"__BEER_INFO__",
    .changeLeague = @"__CHANGE_LEAGUE__",
    .weekDay = @"__WEEK_DAY__",
    .dayChecks = @"__DAY_CHECKS__",
};

@interface BeerVC ()

@property (weak, nonatomic) IBOutlet UIView *splashView;
@property (weak, nonatomic) IBOutlet UILabel *earnedPointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *becomesOwnerLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *beerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *leagueLabel;
@property (weak, nonatomic) IBOutlet UILabel *numGloopsLabel;


@end

@implementation BeerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.hideSplash) {
        [self.splashView setHidden:YES];
    } else {
        //Fullfill splash info
        if ([[self.params objectForKey:BeerParameters.becomeOwner] integerValue] == 3) {
            //Becomes new propietari
            //Show label
            [self.becomesOwnerLabel setHidden:NO];
            //Play sound
            
        }
        //Change league
//        if ([[self.params objectForKey:BeerParameters.changeLeague] integerValue] == 3) {
//            //Becomes new propietari
//            //Show label
//            [self.becomesOwnerLabel setHidden:NO];
//            //Play sound
//            
//        }
    }
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.scrollView.contentSize.height)];
    User *actualUser = ((AppDelegate *)[UIApplication sharedApplication].delegate).actualUser;
    
    
    //Set the labels text
    self.earnedPointsLabel.text = [[self.params objectForKey:BeerParameters.pointsMade] stringValue];
    self.nameLabel.text = self.beer.name;
    self.ownerLabel.text = [self.params objectForKey:BeerParameters.ownerName];
    self.leagueLabel.text = actualUser.league.name;
    self.numGloopsLabel.text = [NSString stringWithFormat:@"%ld Gloops!", (long)[actualUser.experiencePoints integerValue]];
    
    NSURL *url = [NSURL URLWithString:[BASE_URL stringByAppendingPathComponent:self.beer.beerImageURL]];
    [self.beerImage setImageWithURL:url];
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.splashView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.splashView removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
