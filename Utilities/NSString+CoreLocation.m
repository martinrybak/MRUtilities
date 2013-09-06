//
//  NSString+CoreLocation.m
//  Utilities
//
//  Created by Martin Rybak on 9/6/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "NSString+CoreLocation.h"

@implementation NSString (CoreLocation)

- (CLLocationCoordinate2D)coordinate
{
    NSArray* parts = [self componentsSeparatedByString:@","];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [parts[0] doubleValue];
    coordinate.longitude = [parts[1] doubleValue];
    return coordinate;
}

- (NSValue*)coordinateObject
{
	CLLocationCoordinate2D coordinate = [self coordinate];
	return [NSValue value:&coordinate withObjCType:@encode(CLLocationCoordinate2D)];
}

+ (NSString*)stringFromCoordinate:(CLLocationCoordinate2D)coordinate
{
    return [NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude];
}

+ (NSString*)stringFromCoordinateObject:(NSValue*)object
{
    //Unbox the NSvalue to get the underlying coordinate
    CLLocationCoordinate2D coordinate;
    [object getValue:&coordinate];
    
    return [NSString stringFromCoordinate:coordinate];
}

@end
