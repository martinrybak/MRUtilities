//
//  NSDate+Utilities.h
//  Utilities
//
//  Created by Martin Rybak on 9/6/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utilities)

- (NSDate*)datePart;
- (NSTimeInterval)timePart;
- (BOOL)isLessThan:(NSDate*)date;
- (BOOL)isLessThanOrEqualTo:(NSDate*)date;
- (BOOL)isGreaterThan:(NSDate*)date;
- (BOOL)isGreaterThanOrEqualTo:(NSDate*)date;
- (NSDate*)addHours:(int)hours;

@end
