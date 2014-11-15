//
//  legalVC.m
//  ARApp
//
//  Created by Albert Camps Oller on 09/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "legalVC.h"

@interface legalVC () <UIScrollViewAccessibilityDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation legalVC
	
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.scrollView setScrollEnabled:YES];
   // [self.scrollView setContentSize:CGSizeMake(self.view.layer. .size.width, self.view.frame.size.width)];


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
