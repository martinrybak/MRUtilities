//
//  MRTextField.m
//  Utilities
//
//  Created by Martin Rybak on 9/6/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "MRTextField.h"

@interface MRTextField ()

@property (weak, nonatomic) id<UITextFieldDelegate> textFieldDelegate;

@end

@implementation MRTextField

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
}

#pragma mark - UITextField

//Pass through to textFieldDelegate
- (id<UITextFieldDelegate>)delegate
{
	return self.textFieldDelegate;
}

//Pass through to textFieldDelegate
- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
	self.textFieldDelegate = delegate;
}

#pragma mark - UITextFieldDelegate

//If the text field is equal to the default text, clear the text field, and pass through to textFieldDelegate
//If not, return YES
- (BOOL)textFieldShouldBeginEditing:(UITextField*)textField
{
	if ([textField.text isEqualToString:self.defaultText])
		textField.text = nil;
    
	if ([self.textFieldDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
		return [self.textFieldDelegate textFieldShouldBeginEditing:textField];
    
	return YES;
}

//Pass through to textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField*)textField
{
	if ([self.textFieldDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        return [self.textFieldDelegate textFieldDidBeginEditing:textField];
}

//If the text field is empty, set the text to the default text, and pass through to textFieldDelegate
//If not, return YES
- (BOOL)textFieldShouldEndEditing:(UITextField*)textField
{
	if (textField.text.length == 0)
		textField.text = self.defaultText;
    
	if ([self.textFieldDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
		return [self.textFieldDelegate textFieldShouldEndEditing:textField];
    
	return YES;
}

//Pass through to textFieldDelegate
- (void)textFieldDidEndEditing:(UITextField*)textField
{
	if ([self.textFieldDelegate respondsToSelector:@selector(textFieldDidEndEditing:)])
		return [self.textFieldDelegate textFieldDidEndEditing:textField];
}

//Pass through to textFieldDelegate. If not, enforce max length
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
	if ([self.textFieldDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
		return [self.textFieldDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    
    if (textField.text.length >= self.maxLength)
        return NO;
    
	return YES;
}

//Pass through to textFieldDelegate. If not, return YES
- (BOOL)textFieldShouldClear:(UITextField*)textField
{
	if ([self.textFieldDelegate respondsToSelector:@selector(textFieldShouldClear:)])
        return [self.textFieldDelegate textFieldShouldClear:textField];
    
	return YES;
}

//Pass through to textFieldDelegate. If not, return YES
- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
	if ([self.textFieldDelegate respondsToSelector:@selector(textFieldShouldReturn:)])
		return [self.textFieldDelegate textFieldShouldReturn:textField];
    
	return YES;
}

#pragma mark - Public

//Indicates whether there is real user input
- (BOOL)hasValue
{
	if([self.text isEqualToString:self.defaultText])
		return NO;
	return YES;
}

#pragma mark - Private

- (void)setup
{
    //Set this class as the delegate of its superclass, UITextField
    super.delegate = self;
    
    //If there already is a default text set up, save it in defaultText
    if (super.text)
        self.defaultText = super.text;
}

@end
