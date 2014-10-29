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

@interface UserVC ()

@property (nonatomic, strong) User *user;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation UserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.user = [(AppDelegate *)[UIApplication sharedApplication].delegate actualUser];
    self.nameLabel.text = [NSString stringWithFormat:@"Name: %@", self.user.name];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
