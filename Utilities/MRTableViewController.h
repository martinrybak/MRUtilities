//
//  MRTableViewController.h
//  Utilities
//
//  Created by Martin Rybak on 9/5/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRTableViewController : UITableViewController <UITextFieldDelegate>

- (void)textFieldDidEndEditing:(UITextField*)textField inRowAtIndexPath:(NSIndexPath*)indexPath;

@end
