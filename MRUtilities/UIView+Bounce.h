//
//  UIView+Bounce.h
//  Cheq
//
//  Created by Martin Rybak on 7/30/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
	Left = 1,
	Right = 2,
	Top = 3,
	Bottom = 4,
    In = 5,
    Out = 6
} Direction;

@interface UIView (Bounce)

//TODO: add insertSubview variants?
- (void)addSubviewWithBounce:(UIView*)view from:(Direction)direction;
- (void)addSubviewWithBounce:(UIView*)view from:(Direction)direction completion:(void(^)(BOOL finished))completion;
- (void)addSubviewWithBounce:(UIView*)view from:(Direction)direction duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void(^)(BOOL finished))completion;
- (void)removeWithBounceTo:(Direction)direction;
- (void)removeWithBounceTo:(Direction)direction completion:(void(^)(BOOL finished))completion;
- (void)removeWithBounceTo:(Direction)direction duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void(^)(BOOL finished))completion;

@end