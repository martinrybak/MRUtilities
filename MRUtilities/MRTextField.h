//
//  MRTextField.h
//  Utilities
//
//  Created by Martin Rybak on 9/6/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRTextField : UITextField <UITextFieldDelegate>

@property (assign, nonatomic) int maxLength;
@property (strong, nonatomic) NSString* defaultText;
- (BOOL)hasValue;

@end
