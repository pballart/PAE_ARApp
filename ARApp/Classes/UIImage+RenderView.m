//
//  UIImage+RenderView.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 19/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "UIImage+RenderView.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (RenderView)

+ (UIImage *)imageWithView:(UIView*)view cropRect:(CGRect)rect {
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGRect newRect = CGRectMake(rect.origin.x*scale, rect.origin.y*scale, rect.size.width*scale, rect.size.height*scale);
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], newRect);
    
    image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return image;
}

+ (UIImage *)imageWithView:(UIView*)view {
    return [UIImage imageWithView:view cropRect:view.frame];
}

+ (UIImage *)imageWithViewKeepingScale:(UIView*)view {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize newSize = CGSizeMake(view.frame.size.width * scale, view.frame.size.height * scale);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0.0f, 0.0f, newSize.width, newSize.height));
    
    image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return image;
}

@end
