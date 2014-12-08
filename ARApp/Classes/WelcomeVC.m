//
//  WelcomeVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 21/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "WelcomeVC.h"
#import "TutorialCVC.h"


@interface WelcomeVC () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation WelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *const)collectionView numberOfItemsInSection:(NSInteger const)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *const)collectionView cellForItemAtIndexPath:(NSIndexPath *const)indexPath
{
    TutorialCVC *cell;
    cell = (TutorialCVC *)[collectionView dequeueReusableCellWithReuseIdentifier:@"tutorialCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[TutorialCVC alloc] init];
    }
    [cell configureCellAtIndexPath:indexPath];
    return cell;
}


#pragma mark - UICollectionViewDelgate

- (CGSize)collectionView:(UICollectionView *const)collectionView layout:(UICollectionViewLayout *const)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *const)indexPath
{
    return self.view.frame.size;
}

#pragma mark - UIScrollView

- (void)scrollViewDidScroll:(UIScrollView *const)scrollView
{
    if ([scrollView isEqual:self.collectionView]) {
        CGFloat pageWidth = self.collectionView.frame.size.width;
        self.pageControl.currentPage = (self.collectionView.contentOffset.x + pageWidth / 2) / pageWidth;
    }
}

@end
