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
#import "SettingsTVC.h"
#import "RankingTVC.h"

#define  USER_EXP 200
#define  LEVEL_1 1000
#define  LEVEL_2 2000
#define BEERS_BUTTON 0
#define MEDALS_BUTTON 1

@interface UserVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel; //Lliga
@property (strong, nonatomic) IBOutlet UILabel *pointsLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *afegirBirra;

@property (nonatomic, strong) User *user;
@property (strong,nonatomic) NSString *level;
@property int next_level;
@property int progress;



//arrays
@property (strong,  nonatomic) NSMutableArray *data;
@property (strong,  nonatomic) NSMutableArray *beers;
@property (strong,  nonatomic) NSMutableArray *medals;

@end

@implementation UserVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //init mutableArray
    self.data =[[NSMutableArray alloc]
                initWithObjects:@"ESTRELLA DAMM",@"MORITZ",@"SAN MIGUEL",@"VOLL DAMM",@"DUFF",@"CORONITA",@"TSINGTAO",@"BALTIKA 6",@"BALTIKA 7",@"HEINEKEN",@"DAMM LEMON",@"DAMM FREE",nil];
    
    self.beers = [[NSMutableArray alloc]
                  initWithObjects:@"ESTRELLA DAMM",@"MORITZ",@"SAN MIGUEL",@"VOLL DAMM",@"DUFF",@"CORONITA",@"TSINGTAO",@"BALTIKA 6",@"BALTIKA 7",@"HEINEKEN",@"DAMM LEMON",@"DAMM FREE",nil];
    
    self.medals = [[NSMutableArray alloc] initWithObjects:@"FREE NIGHT 0.0",@"1 BEER CHIEF",@"3 BEER CHIEF",@"5 BEER CHIEF",@"USUAL DRINKER",@"LOYAL GLOOPER!",@"WAKE UP AND GLOOP!",@"CANNOT STOP!",@"WHERE IS BOB",@"I CAN SEE THE LIGHT",@"SOMEONE SAID BEER?",@"I INVITE NEXT ROUND!",@"WHERE I LEFT MY GLASS?",@"THINK I AM GOING TO THROW UP",nil];    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.user = [(AppDelegate *)[UIApplication sharedApplication].delegate actualUser];
    self.nameLabel.text = self.user.name;
    self.titleLabel.text = self.user.league.name;
    self.pointsLabel.text = [NSString stringWithFormat:@"%ld Gloops!", (long)[self.user.experiencePoints integerValue]];
    self.progress = (int)self.user.experiencePoints / self.next_level;
}




- (IBAction)segmentedClicked:(id)sender {
    
    if (self.segmentControl.selectedSegmentIndex == BEERS_BUTTON) {
        [self.data removeAllObjects];
        [self.data addObjectsFromArray:self.beers];
        [self.tableView reloadData];
        
    } else if(self.segmentControl.selectedSegmentIndex == MEDALS_BUTTON) {
        [self.data removeAllObjects];
        [self.data addObjectsFromArray:self.medals];
        [self.tableView reloadData];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankingTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"userBeersCell"];
    
    if (!cell) {
        cell = [[RankingTVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userBeersCell"];
    }
    
    Beer *b = [self.beers objectAtIndex:indexPath.row];
    //[cell configureCellWithBeer:b];
    
    
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
    if (self.segmentControl.selectedSegmentIndex == 0){
        BeerVC *beerVC = [[UIStoryboard storyboardWithName:@"Beer" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        //beerVC.beer = [self.data objectAtIndex:indexPath.row];
        beerVC.hideSplash = YES;
        [self presentViewController:beerVC animated:YES completion:nil];
    }
    
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
