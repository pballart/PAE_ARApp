//
//  RankingVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 10/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "RankingVC.h"

@interface RankingVC ()


@property (nonatomic, strong) NSArray *Names_d;
@property (nonatomic, strong) NSArray *Names_w;
@property (nonatomic, strong) NSArray *Names_m;
@property (nonatomic, strong) NSArray *Coses;
@property (nonatomic, strong) NSArray *Brand_d;
@property (nonatomic, strong) NSArray *Brand_w;
@property (nonatomic, strong) NSArray *Brand_m;
@property (nonatomic, strong) NSArray *Subcoses;


@end

@implementation RankingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navigationController.navigationBarHidden = NO;


    
    self.Names_d=@[@"Cervesa Day 1",@"Cervesa Day 2",@"Cervesa Day 3",@"Cervesa Day 4",@"Cervesa Day 5"];
    self.Names_w=@[@"Cervesa Week 1",@"Cervesa Week 2",@"Cervesa Week 3",@"Cervesa Week 4",@"Cervesa Week 5"];
    self.Names_m=@[@"Cervesa Month 1",@"Cervesa Month 2",@"Cervesa Month 3",@"Cervesa Month 4",@"Cervesa Month 5"];
    self.Coses=self.Names_d;
    
    self.Brand_d=@[@"Brand 1",@"Brand 2",@"Brand 3",@"Brand 4",@"Brand 5"];
    self.Brand_w=@[@"Brand 1",@"Brand 2",@"Brand 3",@"Brand 4",@"Brand 5"];
    self.Brand_m=@[@"Brand 1",@"Brand 2",@"Brand 3",@"Brand 4",@"Brand 5"];
    self.Subcoses=self.Brand_d;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.Coses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    
    
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    
    
    cell.textLabel.text = [self.Coses objectAtIndex:(indexPath.row)];
    cell.detailTextLabel.text=[self.Subcoses objectAtIndex:(indexPath.row)];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    NSString *a = [self.Coses objectAtIndex:indexPath.row];
    
    SegonViewController *c = [[UIStoryboard storyboardWithName:@"Segon" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"b"];
    
    c.passo = a;
    
    [self presentViewController:c animated:false completion:nil];
    */
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (IBAction)mySelectorAction:(id)sender {
    switch (self.mySelector.selectedSegmentIndex) {
        case 0:
            //[self.view setBackgroundColor:[UIColor redColor]];
            
            self.Coses=self.Names_d;
            self.Subcoses=self.Brand_d;
            [self.tableV reloadData];
            
            
            break;
            
            
        case 1:
            //[self.view setBackgroundColor:[UIColor greenColor]];
            
            self.Coses=self.Names_w;
            self.Subcoses=self.Brand_w;
            [self.tableV reloadData];
            break;
            
        case 2:
            //[self.view setBackgroundColor:[UIColor yellowColor]];
            
            self.Coses=self.Names_m;
            self.Subcoses=self.Brand_m;
            [self.tableV reloadData];
            break;
        default:
            break;
    }}

- (IBAction)back:(id)sender {
    
   // NSString *a = [self.Coses objectAtIndex:indexPath.row];
    
    UIViewController *c = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    
    //c.passo = a;
    
    [self presentViewController:c animated:false completion:nil];
}
@end
