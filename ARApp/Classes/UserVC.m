//
//  UserVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 10/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "UserVC.h"
#import "User.h"
#import "AppDelegate.h"
#import "PageContentVC.h"
#import "BeerVC.h"
#import "Badge.h"
#import "BadgeCVC.h"
#import "SettingsTVC.h"
#import "RankingTVC.h"
#import "DataSource.h"
#import <pop/POP.h>
#import <SVProgressHUD/SVProgressHUD.h>

#define BEERS_BUTTON 0
#define MEDALS_BUTTON 1


@interface UserVC () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *leagueLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (nonatomic, strong) User *user;
@property (weak, nonatomic) IBOutlet UIView *beerProgressView;
@property (weak, nonatomic) IBOutlet UIImageView *beerProgressImage;
@property (weak, nonatomic) IBOutlet UILabel *emptyTableLabel;

//Data Arrays
@property (strong,  nonatomic) NSMutableArray *beers;
@property (strong,  nonatomic) NSMutableArray *medals;

@end

@implementation UserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.beers = NSMutableArray.array;
    self.medals = NSMutableArray.array;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.beerProgressImage setHidden:YES];
    [self.collectionView setHidden:YES];
    self.emptyTableLabel.hidden = YES;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [SVProgressHUD show];
    self.user = [(AppDelegate *)[UIApplication sharedApplication].delegate actualUser];
    
    [self.beers removeAllObjects];
    [self.medals removeAllObjects];
    
    [[DataSource sharedDataSource] getBeersFromUser:self.user.userId completion:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            //NSLog(@"Received response: %@", dict);
            NSArray *beers = [dict objectForKey:@"birres"];
            for (NSDictionary *d in beers) {
                Beer *b = [[Beer alloc] initBeerWithDictionary:d];
                [self.beers addObject:b];
            }
            if ([self.beers count] > 0) {
                [self.tableView reloadData];
            } else {
                self.emptyTableLabel.hidden = NO;
            }
            
        } else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//            [alert show];
        }
        [SVProgressHUD dismiss];
    }];
    
    [[DataSource sharedDataSource] getLeagueInfoWithLeagueIdentifier:self.user.league.leagueId completion:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            //NSLog(@"Received response: %@", dict);
            [self applyLeagueInfoWithDict:[dict objectForKey:@"league"]];
        } else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//            [alert show];
        }
    }];
    
    //Get badges
    
    [[DataSource sharedDataSource] getBadgeWithUserIdentifier:self.user.userId completion:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            //NSLog(@"Received response: %@", dict);
            for (NSDictionary *d in [dict objectForKey:@"badges"]) {
                Badge *b = [[Badge alloc] initBadgeWithDictionary:d];
                [self.medals addObject:b];
            }
            [self.collectionView reloadData];
        } else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//            [alert show];
        }
    }];
    
    self.nameLabel.text = [self.user.name uppercaseString];
}

-(void)applyLeagueInfoWithDict:(NSDictionary *)dict {

    self.leagueLabel.text = [[dict objectForKey:@"name"] uppercaseString];
    NSInteger maxPoints = [[dict objectForKey:@"maxPoints"] integerValue];
    self.pointsLabel.text = [NSString stringWithFormat:@"%ld / %ld Gloopies", (long)[self.user.experiencePoints integerValue], (long)maxPoints];
    
    //Animate beer progress
    self.beerProgressImage.frame = CGRectMake(0, self.beerProgressView.frame.size.height, self.beerProgressImage.frame.size.width, self.beerProgressImage.frame.size.height);
    [self.beerProgressImage setHidden:NO];
    CGFloat percent = ([self.user.experiencePoints integerValue] * self.beerProgressView.frame.size.height) / maxPoints;
    CGRect frame = self.beerProgressImage.frame;
    frame.origin.y = self.beerProgressView.frame.size.height - percent;
    
    POPSpringAnimation *anim = [POPSpringAnimation animation];
    anim.delegate = self;
    anim.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    anim.toValue = [NSValue valueWithCGRect:frame];
    [self.beerProgressImage pop_addAnimation:anim forKey:@"scanButton"];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.beerProgressImage setHidden:YES];
}

- (IBAction)segmentedClicked:(id)sender {
    
    if (self.segmentControl.selectedSegmentIndex == BEERS_BUTTON) {
        [self.collectionView setHidden:YES];
        
    } else if(self.segmentControl.selectedSegmentIndex == MEDALS_BUTTON) {
        [self.collectionView setHidden:NO];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.beers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankingTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"userBeersCell"];
    
    if (!cell) {
        cell = [[RankingTVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userBeersCell"];
    }
    
    Beer *b = [self.beers objectAtIndex:indexPath.row];
    [cell configureCellWithBeer:b];
    
    
    if(indexPath.row%2==0){
        [cell setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:219.0/255.0 blue:75.0/255.0 alpha:1.0]];
    }
    else{
        [cell setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0]];
    }
    return cell;
}


#pragma mark - Table View delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    if (self.segmentControl.selectedSegmentIndex == BEERS_BUTTON){
        BeerVC *beerVC = [[UIStoryboard storyboardWithName:@"Beer" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        beerVC.beer = [self.beers objectAtIndex:indexPath.row];
        beerVC.hideSplash = YES;
        [self presentViewController:beerVC animated:YES completion:nil];
    }
}

#pragma mark - CollectionView DataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.medals count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BadgeCVC *cell = (BadgeCVC *)[collectionView dequeueReusableCellWithReuseIdentifier:@"userBadgeCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[BadgeCVC alloc] init];
    }
    
    Badge *b = [self.medals objectAtIndex:indexPath.row];
    [cell configureCellWithBadge:b];
    
    return cell;
}


#pragma mark - CollectionView Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = collectionView.bounds.size.width/3-10;
    return CGSizeMake(width, width);
}


#pragma mark - Navigation

- (IBAction)goToCamera:(UIBarButtonItem *)sender {
    [(PageContentVC*)self.navigationController.parentViewController moveToCameraWithDirectionRight:YES];
}

- (IBAction)showSettings:(id)sender {
    SettingsTVC *settingsTVC = [[UIStoryboard storyboardWithName:@"Settings" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [self presentViewController:settingsTVC animated:YES completion:nil];
}


@end
