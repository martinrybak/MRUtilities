//
//  NSString+Helpers.m
//  Utilities
//
//  Created by Martin Rybak on 8/30/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "NSString+Helpers.h"

@implementation NSString (Helpers)

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

@end
