//
//  RankingVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 10/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "RankingVC.h"
#import "PageContentVC.h"
#import "RankingTVC.h"
#import "DataSource.h"
#import "Beer.h"
#import "User.h"
#import "UIImage+RenderView.h"
#import "AppDelegate.h"
#import "BeerVC.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface RankingVC ()

@property (nonatomic, strong) NSMutableArray *dayRank;
@property (nonatomic, strong) NSMutableArray *weekRank;
@property (nonatomic, strong) NSMutableArray *totalRank;
@property (nonatomic, strong) NSMutableArray *userRank;
@property (nonatomic, strong) NSArray *actualRank;

@end

@implementation RankingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Load ranking from server
    self.dayRank = NSMutableArray.array;
    self.weekRank = NSMutableArray.array;
    self.totalRank = NSMutableArray.array;
    self.userRank = NSMutableArray.array;
    self.actualRank = NSArray.array;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    [SVProgressHUD show];
    [self loadDailyRanking];
    [self loadWeeklyRanking];
    [self loadTotalRanking];
    [self loadUserRanking];
}

-(void) loadDailyRanking {
    [[DataSource sharedDataSource] getRankingDailyWithcompletion:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            [self.dayRank removeAllObjects];
            //NSLog(@"Ranking: %@", dict);
            NSArray *retrievedBeers = [dict objectForKey:@"ranking"];
            for (NSDictionary *d in retrievedBeers) {
                Beer *b = [[Beer alloc] initBeerWithDictionary:d];
                [self.dayRank addObject:b];
            }
            self.actualRank = self.dayRank;
            [self updateTable];
        } else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//            [alert show];
        }
        [SVProgressHUD dismiss];
    }];
}

-(void) loadWeeklyRanking {
    [[DataSource sharedDataSource] getRankingWeeklyWithcompletion:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            [self.weekRank removeAllObjects];
            //NSLog(@"Ranking: %@", dict);
            NSArray *retrievedBeers = [dict objectForKey:@"ranking"];
            for (NSDictionary *d in retrievedBeers) {
                Beer *b = [[Beer alloc] initBeerWithDictionary:d];
                [self.weekRank addObject:b];
            }
            [self updateTable];
        } else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//            [alert show];
        }
    }];
}

-(void) loadTotalRanking {
    [[DataSource sharedDataSource] getRankingTotalWithcompletion:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            [self.totalRank removeAllObjects];
            //NSLog(@"Ranking: %@", dict);
            NSArray *retrievedBeers = [dict objectForKey:@"ranking"];
            for (NSDictionary *d in retrievedBeers) {
                Beer *b = [[Beer alloc] initBeerWithDictionary:d];
                [self.totalRank addObject:b];
            }
            [self updateTable];
        } else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//            [alert show];
        }
    }];
}

-(void) loadUserRanking {
    [[DataSource sharedDataSource] getRankingTopTenUsersWithcompletion:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            [self.userRank removeAllObjects];
            //NSLog(@"Ranking: %@", dict);
            NSArray *retrievedBeers = [dict objectForKey:@"ranking"];
            for (NSDictionary *d in retrievedBeers) {
                User *u = [[User alloc] initUserWithRankingDictionary:d];
                [self.userRank addObject:u];
            }
            [self updateTable];
        } else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//            [alert show];
        }
    }];
}

-(void) updateTable {
    switch (self.mySelector.selectedSegmentIndex) {
        case 0:
            self.actualRank=self.dayRank;
            [self.tableV reloadData];
            break;
        case 1:
            self.actualRank=self.weekRank;
            [self.tableV reloadData];
            break;
            
        case 2:
            self.actualRank=self.totalRank;
            [self.tableV reloadData];
            break;
        case 3:
            self.actualRank=self.userRank;
            [self.tableV reloadData];
            break;
        default:
            break;
    }
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.actualRank count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RankingTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"rankingCellId"];
    
    if (!cell) {
        cell = [[RankingTVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rankingCellId"];
    }
    
    if ([[self.actualRank firstObject] isKindOfClass:[Beer class]]) {
        Beer *b = [self.actualRank objectAtIndex:indexPath.row];
        [cell configureCellWithBeer:b];
    } else if ([[self.actualRank firstObject] isKindOfClass:[User class]]) {
        User *u = [self.actualRank objectAtIndex:indexPath.row];
        [cell configureCellWithUser:u];
    }
    
    
    [cell configureCellWithNumberPos:indexPath.row];
    
    if (indexPath.row <=2) {
        [cell configureCellWithImageName:@"birraRanking"];
        [cell setToInvisible];
        
    }
    

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
    if (self.mySelector.selectedSegmentIndex != 3){
        BeerVC *beerVC = [[UIStoryboard storyboardWithName:@"Beer" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        beerVC.beer = [self.actualRank objectAtIndex:indexPath.row];
        beerVC.hideSplash = YES;
        [self presentViewController:beerVC animated:YES completion:nil];
    }
}

- (IBAction)shareActualRanking:(UIBarButtonItem *)sender {
    UIImageView *screenShot = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    screenShot.image = [UIImage imageWithView:[(AppDelegate *)[[UIApplication sharedApplication] delegate] window]];
//    NSAssert(screenShot.image != nil, @"Error nil image");
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[screenShot.image] applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)mySelectorAction:(id)sender {
    [self updateTable];
}


- (IBAction)back:(id)sender {
    [(PageContentVC*)self.navigationController.parentViewController moveToCameraWithDirectionRight:NO];
}
@end
