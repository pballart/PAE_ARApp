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
    
    if ((NSInteger)self.user.experiencePoints<=LEVEL_1) {
        self.level = @"NOOB";
        self.next_level = LEVEL_1;
    }
    else{
        self.level = @"Pro";
        self.next_level = LEVEL_2;
    }
    
    
    //[self popTest];
    
        self.afegirBirra.frame = CGRectMake(0,0,0,0);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:2.5]; //the time you want the animation to last for
        self.afegirBirra.frame = CGRectMake(0,0,0,-70);
        [UIView commitAnimations];
    //[self colocar:self.afegirBirra];
    
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

/*
- (void) colocar:(UIImageView *) image{
    CGPoint point0 = image.layer.position;
    CGPoint point1 = { point0.x, point0.y-20.0};
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.y"];
    anim.fromValue    = @(point0.y);
    anim.toValue  = @(point1.y);
    anim.duration   = 1.0f;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // First we update the model layer's property.
    image.layer.position = point1;
    
    // Now we attach the animation.
    [image.layer  addAnimation:anim forKey:@"position.y"];
    
}


- (void) popTest {
    UINavigationController *nav = (UINavigationController*) self.view.window.rootViewController;
    UIViewController *root = [nav.viewControllers objectAtIndex:0];
    [root performSelector:@selector(returnToRoot)];
}
*/


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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if(cell == nil){
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    [self paintCell:cell didSelectRowAtIndexPath:indexPath];
    
    return cell;
}

-(void)paintCell:(UITableViewCell *) cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.segmentControl.selectedSegmentIndex == 0){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.textLabel.textColor =[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:153.0/255.0 alpha:1.0];
    cell.accessoryView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:153.0/255.0 alpha:1.0];
    
    if(indexPath.row%2==0){
        
        [cell setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:184.0/255.0 blue:24.0/255.0 alpha:1.0]];
    }
    
    else{
        [cell setBackgroundColor:[UIColor colorWithRed:254.0/255.0 green:203.0/255.0 blue:52.0/255.0 alpha:1.0]];
    }

}

#pragma mark - Table View delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    if (self.segmentControl.selectedSegmentIndex == 0){
        //s'ha de canviar UserVC per BeerVC
        BeerVC *beerVC = [[UIStoryboard storyboardWithName:@"Beer" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        beerVC.beer = [self.data objectAtIndex:indexPath.row];
        beerVC.hideSplash = YES;
        [self presentViewController:beerVC animated:YES completion:nil];
    }
    
}

#pragma mark - Navigation

- (IBAction)goToCamera:(UIBarButtonItem *)sender {
    [(PageContentVC*)self.navigationController.parentViewController moveToCameraWithDirectionRight:YES];
}



@end
