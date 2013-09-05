//
//  MRTableViewController.m
//  Utilities
//
//  Created by Martin Rybak on 9/5/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "MRTableViewController.h"

@implementation MRTableViewController

#pragma mark - Public

//To be overriden by subclass
- (void)textField:(UITextField*)textField didUpdateAtIndexPath:(NSIndexPath*)indexPath
{
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField*)textField
{
    UITableViewCell* cell = (UITableViewCell*)textField.superview.superview; //TODO allow for deeper nesting
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
	[self.tableView endEditing:YES];
	[self textField:textField didUpdateAtIndexPath:indexPath];
}


@end
