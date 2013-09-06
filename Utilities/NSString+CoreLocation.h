//
//  NSString+CoreLocation.h
//  Utilities
//
//  Created by Martin Rybak on 9/6/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NSString (CoreLocation)

- (CLLocationCoordinate2D)coordinate;
- (NSValue*)coordinateObject;
+ (NSString*)stringFromCoordinate:(CLLocationCoordinate2D)coordinate;
+ (NSString*)stringFromCoordinateObject:(NSValue*)object;

@end
