//
//  NSNumber+Random.m
//  MRUtilities
//
//  Created by Martin Rybak on 10/29/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "NSNumber+Random.h"

@implementation NSNumber (Random)

//Generates a random number in the range given (inclusive)
+ (int)randomIntegerBetween:(int)from and:(int)to
{
	int random = arc4random_uniform(to - from + 1) + from;
	return random;
}

@end
