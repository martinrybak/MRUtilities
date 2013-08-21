//
//  UIView+Animation.m
//  Cheq
//
//  Created by Martin Rybak on 8/2/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

- (void)animateTo:(CGPoint)point duration:(float)duration
{
	[UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		[self moveTo:point];
	} completion:nil];
}

- (void)animateTo:(CGPoint)point duration:(float)duration completion:(void(^)(BOOL))completion
{
	[UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		[self moveTo:point];
	} completion:^(BOOL finished) {
		if (completion)
			completion(finished);
	}];
}

- (void)animateTo:(CGPoint)point duration:(float)duration options:(UIViewAnimationOptions)options completion:(void(^)(BOOL finished))completion
{
	[UIView animateWithDuration:duration delay:0.0 options:options animations:^{
		[self moveTo:point];
	} completion:^(BOOL finished) {
		if (completion)
			completion(finished);
	}];
}

- (void)animateRotation:(float)degrees duration:(float)duration
{
	[UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		[self rotate:degrees];
	} completion:nil];
}

- (void)animateRotation:(float)degrees duration:(float)duration completion:(void (^)(BOOL))completion
{
	[UIView animateWithDuration:duration animations:^{
		[self rotate:degrees];
	} completion:^(BOOL finished) {
		if (completion)
			completion(finished);
	}];
}

- (void)animateRotation:(float)degrees duration:(float)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL))completion
{
	[UIView animateWithDuration:duration delay:0.0 options:options animations:^{
		[self rotate:degrees];
	} completion:^(BOOL finished) {
		if (completion)
			completion(finished);
	}];
}

- (void)rotate:(float)degrees
{
	self.transform = CGAffineTransformMakeRotation(degrees / 180.0 * M_PI);
}

- (void)performAnimation:(CAAnimation*)animation afterDelay:(NSTimeInterval)delay andAfter:(void(^)(void))action
{
	id actionParameter;
	if (action)
		actionParameter = action;
	else
		actionParameter = [NSNull null];
	
	//Create array to contain both animation and action parameters
	NSArray* parameters = @[ animation, actionParameter ];
	[self performSelector:@selector(performAnimation:) withObject:parameters afterDelay:delay];
}

- (void)performAnimation:(NSArray*)parameters
{
	//Extract parameters from array
	CAAnimation* animation = parameters[0];
	void(^action)(void) = parameters[1];
	
	if (action) {
		action();
	}
	
    [self.layer addAnimation:animation forKey:@"animation"];
}

- (CGRect)offRight
{
	if(!self.superview)
		[NSException raise:NSInvalidArgumentException format:@"View must be inside a superview"];
	
    return CGRectMake(self.superview.frame.size.width,
                      self.frame.origin.y,
                      self.frame.size.width,
                      self.frame.size.height);
}

- (CGRect)offLeft
{
    return CGRectMake(-self.frame.size.width,
                      self.frame.origin.y,
                      self.frame.size.width,
                      self.frame.size.height);
}

- (CGRect)offTop
{
    return CGRectMake(self.frame.origin.x,
                      -self.frame.size.height,
                      self.frame.size.width,
                      self.frame.size.height);
}

- (CGRect)offBottom
{
	if(!self.superview)
		[NSException raise:NSInvalidArgumentException format:@"View must be inside a superview"];
	
    return CGRectMake(self.frame.origin.x,
                      self.superview.frame.size.height,
                      self.frame.size.width,
                      self.frame.size.height);
}

- (void)moveTo:(CGPoint)point
{
	self.center = point;
}

- (void)moveOffRight
{
	self.frame = [self offRight];
}

- (void)moveOffLeft
{
	self.frame = [self offLeft];
}

- (void)moveOffBottom
{
	self.frame = [self offBottom];
}

- (void)moveOffTop
{
	self.frame = [self offTop];
}

- (BOOL)containsPoint:(CGPoint)point
{
	return CGRectContainsPoint(self.frame, point);
}

- (void)printFrame:(NSString*)identifier
{
	NSLog(@"%@ frame: %f,%f,%f,%f", identifier, self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)printBounds:(NSString*)identifier
{
	NSLog(@"%@ bounds: %f,%f,%f,%f", identifier, self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
}

+ (CGPoint)getCenter:(CGRect)rect
{
	return CGPointMake(rect.origin.x + rect.size.width / 2,
					   rect.origin.y + rect.size.height / 2 );
}

- (void)pause
{
	CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
	self.layer.speed = 0.0;
	self.layer.timeOffset = pausedTime;
}

- (void)resume
{
	CFTimeInterval pausedTime = [self.layer timeOffset];
	self.layer.speed = 1.0;
	self.layer.timeOffset = 0.0;
	self.layer.beginTime = 0.0;
	CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
	self.layer.beginTime = timeSincePause;
}

@end
