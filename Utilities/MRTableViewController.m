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
- (void)textFieldDidEndEditing:(UITextField*)textField inRowAtIndexPath:(NSIndexPath*)indexPath
{
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField*)textField
{
    [self.tableView endEditing:YES];
    UITableViewCell* cell = [self parentCellFor:textField];
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
	[self textFieldDidEndEditing:textField inRowAtIndexPath:indexPath];
	[self.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
}

- (UITableViewCell*)parentCellFor:(UIView*)view
{
    if (!view)
        return nil;
    if ([view isMemberOfClass:[UITableViewCell class]])
         return (UITableViewCell*)view;
    return [self parentCellFor:view.superview];
}

@end
