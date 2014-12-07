//
//  BadgeCVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 7/12/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "BadgeCVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DataSource.h"

@implementation BadgeCVC

-(instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.imageView];
    }
    return self;
}

-(void)configureCellWithBadge:(Badge *)badge
{
    NSURL *url = [NSURL URLWithString:[API_BASE_URL stringByAppendingPathComponent:badge.image]];
    [self.imageView sd_setImageWithURL:url];
}

-(void)prepareForReuse
{
    self.imageView.image = nil;
}
@end
