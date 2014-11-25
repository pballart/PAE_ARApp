//
//  TutorialPageContentVC.m
//  ARApp
//
//  Created by Joan Ficapal Vila on 07/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "TutorialPageContentVC.h"
#import "PagTutorial.h"
#import "Pag2Tutorial.h"
#import "Pag3Tutorial.h"


@interface TutorialPageContentVC ()<UIPageViewControllerDataSource>
@property (nonatomic, strong) PagTutorial *tut0;
@property (nonatomic, strong) Pag2Tutorial *tut1;
@property (nonatomic, strong) Pag3Tutorial *tut2;


@end

@implementation TutorialPageContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // self.dataSource = self;
 
    self.tut0 = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tutorial1"];
       //self.dataSource = self;
    self.tut1 = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tutorial2"];
    self.tut2 = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"tutorial3"];

    self.dataSource = self;
    NSArray *viewControllers = @[self.tut0];
    
    
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    
    
    // Create page view controller

   
    /*
    TutorialPageContentVC *startingViewController =  @[self.tut0] ;
   // NSArray *viewControllers = @[self.tut0];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
[PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tutorial1"];

     */
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



#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[Pag2Tutorial class]]) {
      
        return self.tut0;
       
        
    } else  if ([viewController isKindOfClass:[Pag3Tutorial class]]) {
        
        return self.tut1;
        
    } else {
        return nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[Pag2Tutorial class]]) {
        
        return self.tut2;
        
        
    } else  if ([viewController isKindOfClass:[PagTutorial class]]) {
 
        return self.tut1;
        
    } else {
        return nil;
    }
}



@end
