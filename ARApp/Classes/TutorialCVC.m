//
//  TutorialCVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 7/12/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "TutorialCVC.h"

@implementation TutorialCVC


-(void)awakeFromNib
{
    [super awakeFromNib];
    [self prepareForReuse];
}

-(void)prepareForReuse {
    self.imageView.image = nil;
}

-(void) configureCellAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            self.imageView.image = [UIImage imageNamed:@"tutorial1.jpg"];
            break;
        case 1:
            self.imageView.image = [UIImage imageNamed:@"tutorial2.jpg"];
            break;
        case 2:
            self.imageView.image = [UIImage imageNamed:@"tutorial3.jpg"];
            break;
        case 3:
            self.imageView.image = [UIImage imageNamed:@"tutorial4.jpg"];
            break;
        default:
            break;
    }
    
}

@end
