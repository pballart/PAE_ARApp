//
//  PageContentVC.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 10/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentVC : UIPageViewController

-(void) moveToRanking;
-(void) moveToUser;
-(void) moveToCameraWithDirectionRight:(BOOL)right;
@end
