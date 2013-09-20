//
//  UIView+XIB.m
//  Cheq
//
//  Created by Martin Rybak on 8/19/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "UIView+XIB.h"

@implementation UIView (XIB)

- (void)loadFromXib
{
	//Load the xib file with the same name as the extended class
	UINib* nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
	
	//Get all the UIViews at the root level of the Xib
	NSArray* views = [nib instantiateWithOwner:self options:nil];
	
	//Add each one to self's subview collection
	for (UIView* view in views)
		[self addSubview:view];
}

@end
