//
//  TutorialCVC.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 7/12/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialCVC : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

-(void) configureCellAtIndexPath:(NSIndexPath *)indexPath;

@end
