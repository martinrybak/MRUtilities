//
//  UIView+Animation.h
//  Cheq
//
//  Created by Martin Rybak on 8/2/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <QuartzCore/QuartzCore.h>

@interface UIView (Animation)

- (void)animateTo:(CGPoint)point duration:(float)duration;
- (void)animateTo:(CGPoint)point duration:(float)duration completion:(void(^)(BOOL finished))completion;
- (void)animateTo:(CGPoint)point duration:(float)duration options:(UIViewAnimationOptions)options completion:(void(^)(BOOL finished))completion;
- (void)animateRotation:(float)degrees duration:(float)duration;
- (void)animateRotation:(float)degrees duration:(float)duration completion:(void(^)(BOOL finished))completion;
- (void)animateRotation:(float)degrees duration:(float)duration options:(UIViewAnimationOptions)options completion:(void(^)(BOOL finished))completion;
- (void)performAnimation:(CAAnimation*)animation afterDelay:(NSTimeInterval)delay andAfter:(void(^)(void))action;
- (void)rotate:(float)degrees;
- (void)moveTo:(CGPoint)point;
- (void)moveOffRight;
- (void)moveOffLeft;
- (void)moveOffBottom;
- (void)moveOffTop;
- (CGRect)offRight;
- (CGRect)offLeft;
- (CGRect)offTop;
- (CGRect)offBottom;
- (BOOL)containsPoint:(CGPoint)point;
+ (CGPoint)getCenter:(CGRect)rect;
- (void)printFrame:(NSString*)identifier;
- (void)printBounds:(NSString*)identifier;
- (void)pause;
- (void)resume;

@end
