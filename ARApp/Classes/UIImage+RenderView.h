//
//  UIImage+RenderView.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 19/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RenderView)
+ (UIImage *)imageWithView:(UIView*)view;
+ (UIImage *)imageWithView:(UIView*)view cropRect:(CGRect)rect;
+ (UIImage *)imageWithViewKeepingScale:(UIView*)view;
@end
