//
//  NSDate+Utilities.m
//  Utilities
//
//  Created by Martin Rybak on 9/6/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "NSDate+Utilities.h"

@implementation NSDate (Utilities)

- (NSDate*)datePart
{
	NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
	return [calendar dateFromComponents:components];
}

- (NSTimeInterval)timePart
{
	NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents* components = [calendar components:NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:self];
	return components.hour * 60 * 60 + components.minute * 60 + components.second;
}

- (BOOL)isLessThan:(NSDate*)date
{
	if ([self compare:date] == NSOrderedAscending)
		return YES;
	return NO;
}

- (BOOL)isLessThanOrEqualTo:(NSDate*)date
{
	if ([self compare:date] == NSOrderedAscending || [self compare:date] == NSOrderedSame)
		return YES;
	return NO;
}

- (BOOL)isGreaterThan:(NSDate*)date
{
	if ([self compare:date] == NSOrderedDescending)
		return YES;
	return NO;
}

- (BOOL)isGreaterThanOrEqualTo:(NSDate*)date
{
	if ([self compare:date] == NSOrderedDescending || [self compare:date] == NSOrderedSame)
		return YES;
	return NO;
}

- (NSDate*)addHours:(int)hours
{
	//Convert hours to seconds
	int seconds = 60 * 60 * hours;
	return [self dateByAddingTimeInterval:seconds];
}

@end
