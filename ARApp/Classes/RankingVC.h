//
//  RankingVC.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 10/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingVC : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySelector;
- (IBAction)mySelectorAction:(id)sender;

- (IBAction)back:(id)sender;





@property (weak, nonatomic) IBOutlet UITableView *tableV;

@end
