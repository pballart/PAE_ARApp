//
//  BadgeCVC.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 7/12/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Badge.h"

@interface BadgeCVC : UICollectionViewCell
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

-(void)configureCellWithBadge:(Badge *)badge;
@end
