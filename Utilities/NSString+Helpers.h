//
//  NSString+Helpers.h
//  Utilities
//
//  Created by Martin Rybak on 8/30/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helpers)

- (BOOL)contains:(NSString*)substring;
- (NSString*)trim;
- (BOOL)isPrice;
- (BOOL)isInteger;

@end
