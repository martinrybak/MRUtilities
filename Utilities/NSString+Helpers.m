//
//  NSString+Helpers.m
//  Utilities
//
//  Created by Martin Rybak on 8/30/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "NSString+Helpers.h"

@implementation NSString (Helpers)

+ (BOOL)isNilOrEmpty:(NSString*)string;
{
    if (string && string.length)
		return NO;
	return YES;
}

- (BOOL)contains:(NSString*)substring
{
    NSRange range = [self rangeOfString:substring];
    BOOL found = (range.location != NSNotFound);
    return found;
}

- (NSString*)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//TODO: internationalize?
- (BOOL)isPrice
{
    return [self isMatch:@"\\d*\\.\\d{1}\\d{1}"];
}

//TODO: int range check
- (BOOL)isInteger
{
    return [self isMatch:@"^[\\d]*$"];
}

- (BOOL)isMatch:(NSString*)pattern
{
	NSError* error = nil;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    NSRange range = [regex rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    if (NSEqualRanges(range, NSMakeRange(NSNotFound, 0)))
        return NO;
    return YES;
}

@end
