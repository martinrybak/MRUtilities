//
//  UIView+Bounce.h
//  Cheq
//
//  Created by Martin Rybak on 7/30/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "UIView+Bounce.h"
#import "UIView+Animation.h"
#include <QuartzCore/QuartzCore.h>

@implementation UIView (Bounce)

const float DEFAULT_OFFSET = 10.0;
const float DEFAULT_DURATION = 0.3;

typedef enum
{
  Horizontal = 1,
  Vertical = 2
} Axis;

#pragma mark - Public methods

- (void)addSubviewWithBounce:(UIView*)view from:(Direction)direction;
{
    [self addSubviewWithBounce:view from:direction duration:DEFAULT_DURATION delay:0.0 completion:nil];
}

- (void)addSubviewWithBounce:(UIView *)view from:(Direction)direction completion:(void (^)(BOOL))completion
{
    [self addSubviewWithBounce:view from:direction duration:DEFAULT_DURATION delay:0.0 completion:completion];
}

- (void)addSubviewWithBounce:(UIView*)view from:(Direction)direction duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void(^)(BOOL finished))completion
{
    Axis axis;
	float startValue;
	float endValue;
    CAAnimation* animation;
		
    //First hide the view (it will be unhidden later in performAnimation:)
    view.hidden = YES;
    
    //Add the view as a subview so moveOffRight: and moveOffBottom: can access superview in their calculations
	[self addSubview:view];
    
    //The current view's frame is where we want to end up
    CGRect endFrame = view.frame;
		
	//Determine parameters based on direction
	switch(direction)
	{
		case Left:
			axis = Horizontal;
			endValue = view.center.x;
			[view moveOffLeft];
			startValue = view.center.x;
            animation = [UIView bounceFrom:startValue to:endValue axis:axis offset:DEFAULT_OFFSET direction:direction];
			break;
		case Right:
			axis = Horizontal;
			endValue = view.center.x;
			[view moveOffRight];
			startValue = view.center.x;
            animation = [UIView bounceFrom:startValue to:endValue axis:axis offset:DEFAULT_OFFSET direction:direction];
			break;
		case Top:
			axis = Vertical;
			endValue = view.center.y;
			[view moveOffTop];
			startValue = view.center.y;
            animation = [UIView bounceFrom:startValue to:endValue axis:axis offset:DEFAULT_OFFSET direction:direction];
			break;
		case Bottom:
			axis = Vertical;
			endValue = view.center.y;
			[view moveOffBottom];
			startValue = view.center.y;
            animation = [UIView bounceFrom:startValue to:endValue axis:axis offset:DEFAULT_OFFSET direction:direction];
			break;
        case In:
            animation = [UIView bounceIn];
            ((CABasicAnimation*) animation).additive = YES;
            break;
        default:
            return;
	}
	
	//Append to the original passed-in completion block
    __weak typeof(self) weakself = self;
    void(^newCompletion)(BOOL) = ^(BOOL finished) {
        if(completion)
            completion(finished);
        [weakself setUserInteractionEnabled:YES]; //Enable user interaction
		view.frame = endFrame; //Update the layer's frame to what it was at the beginning
    };
    
    //Set additional animation settings
    animation.duration = duration;
	animation.delegate = self;
	[animation setValue:newCompletion forKey:@"completion"];
	animation.fillMode = kCAFillModeForwards;
	animation.removedOnCompletion = NO;
    
    //Unhide view and perform animation
	[view performAnimation:animation afterDelay:delay andAfter:^{
		view.hidden = NO;
	}];
}

- (void)removeWithBounceTo:(Direction)direction
{
    [self removeWithBounceTo:direction duration:DEFAULT_DURATION delay:0.0 completion:nil];
}

- (void)removeWithBounceTo:(Direction)direction completion:(void (^)(BOOL))completion
{
    [self removeWithBounceTo:direction duration:DEFAULT_DURATION delay:0.0 completion:completion];
}

- (void)removeWithBounceTo:(Direction)direction duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void(^)(BOOL finished))completion
{
    Axis axis;
    float startValue;
	float endValue;
    CGRect endFrame;
    CAAnimation* animation;
	
	//Disable view
	[self setUserInteractionEnabled:NO];
	
	//Determine parameters based on direction
	switch(direction)
	{
		case Left:
			axis = Horizontal;
			startValue = self.center.x;
			endFrame = [self offLeft];
			endValue = [UIView getCenter:endFrame].x;
            animation = [UIView bounceTo:endValue from:startValue axis:axis offset:DEFAULT_OFFSET direction:direction];
			break;
		case Right:
			axis = Horizontal;
			startValue = self.center.x;
			endFrame = [self offRight];
			endValue = [UIView getCenter:endFrame].x;
            animation = [UIView bounceTo:endValue from:startValue axis:axis offset:DEFAULT_OFFSET direction:direction];
			break;
		case Top:
			axis = Vertical;
			startValue = self.center.y;
			endFrame = [self offTop];
			endValue = [UIView getCenter:endFrame].y;
            animation = [UIView bounceTo:endValue from:startValue axis:axis offset:DEFAULT_OFFSET direction:direction];
			break;
		case Bottom:
			axis = Vertical;
			startValue = self.center.y;
			endFrame = [self offBottom];
			endValue = [UIView getCenter:endFrame].y;
            animation = [UIView bounceTo:endValue from:startValue axis:axis offset:DEFAULT_OFFSET direction:direction];
            break;
        case Out:
            endFrame = self.frame;
            animation = [UIView bounceOut];
            ((CABasicAnimation*) animation).additive = YES;
            break;
        default:
            return;
	}
	
	//Append to the original passed-in completion block
    __weak typeof(self) weakself = self;
    void(^newCompletion)(BOOL) = ^(BOOL finished) {
        if(completion)
            completion(finished);
        [weakself removeFromSuperview];
    };
        
    //Set additional animation settings
    animation.duration = duration;
	animation.delegate = self;
	[animation setValue:newCompletion forKey:@"completion"];
	animation.fillMode = kCAFillModeForwards;
	animation.removedOnCompletion = NO;

    //Perform animation	
	[self performAnimation:animation afterDelay:delay andAfter:nil];
    
    //Update the layer's frame
    self.layer.frame = endFrame;
}

#pragma mark - CAAnimation delegate

- (void) animationDidStop:(CAAnimation*)animation finished:(BOOL)flag
{
	void(^completion)(BOOL) = [animation valueForKey:@"completion"];
	if(completion)
		completion(flag);
}

#pragma mark - Private methods

+ (CAAnimation*) bounceFrom:(float)startPosition to:(float)endPosition axis:(Axis)axis offset:(float)offset direction:(Direction)direction
{
    NSString* keyPath;
    if (axis == Horizontal)
        keyPath = @"position.x";
    else
        keyPath = @"position.y";
	
	if (direction == Left || direction == Top)
		offset *= -1;
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    [animation setValues:@[
        [NSNumber numberWithFloat:startPosition],
        [NSNumber numberWithFloat:endPosition - offset],
        [NSNumber numberWithFloat:endPosition + offset / 2],
        [NSNumber numberWithFloat:endPosition]
    ]];
    [animation setKeyTimes:@[
        [NSNumber numberWithFloat:0.0],
        [NSNumber numberWithFloat:0.4],
        [NSNumber numberWithFloat:0.8],
        [NSNumber numberWithFloat:1.0]
    ]];
    [animation setTimingFunctions:@[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
    ]];
    
    return animation;
}

+ (CAAnimation*) bounceTo:(float)endPosition from:(float)startPosition axis:(Axis)axis offset:(float)offset	direction:(Direction)direction
{
	//Select key path according to axis
    NSString* keyPath;
    if (axis == Horizontal)
        keyPath = @"position.x";
    else
        keyPath = @"position.y";
	
	//Invert offset for Left and Top
	if (direction == Left || direction == Top)
		offset *= -1;
    
	//Create the animation object
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    [animation setValues:@[
        [NSNumber numberWithFloat:startPosition],
        [NSNumber numberWithFloat:startPosition - offset / 2],
        [NSNumber numberWithFloat:startPosition + offset],
        [NSNumber numberWithFloat:endPosition]
    ]];
    [animation setKeyTimes:@[
        [NSNumber numberWithFloat:0.0],
        [NSNumber numberWithFloat:0.4],
        [NSNumber numberWithFloat:0.8],
        [NSNumber numberWithFloat:1.0]
    ]];
    [animation setTimingFunctions:@[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]
    ]];
    
    return animation;
}

+ (CAAnimation*)bounceIn
{
	CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];

    [animation setValues:@[
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]
    ]];
    [animation setKeyTimes:@[
        [NSNumber numberWithFloat:0.0f],
        [NSNumber numberWithFloat:0.5f],
        [NSNumber numberWithFloat:0.9f],
        [NSNumber numberWithFloat:1.0f]
    ]];
    [animation setTimingFunctions:@[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
    ]];
    
	return animation;
}

+ (CAAnimation*)bounceOut
{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    [animation setValues:@[
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0)]
    ]];
    [animation setKeyTimes:@[
        [NSNumber numberWithFloat:0.0f],
        [NSNumber numberWithFloat:0.1f],
        [NSNumber numberWithFloat:0.5f],
        [NSNumber numberWithFloat:1.0f]
    ]];
    [animation setTimingFunctions:@[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
    ]];
    
	return animation;
}

@end
