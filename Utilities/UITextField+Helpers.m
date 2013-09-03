//
//  UITextField+Helpers.m
//  Utilities
//
//  Created by Martin Rybak on 9/3/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "UITextField+Helpers.h"

@implementation UITextField (Helpers)

- (void)resizeForFont:(UIFont*)font
{
	CGRect frame = self.frame;
	NSString* text = [self.text stringByAppendingString:@"   "];
	frame.size.width = [text sizeWithFont:font].width;
	self.frame = frame;
}

@end
