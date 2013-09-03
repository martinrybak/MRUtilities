//
//  MRNavigationController.m
//  Utilities
//
//  Created by Martin Rybak on 9/3/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import "MRNavigationController.h"

@interface MRNavigationController ()

@property (copy, nonatomic) void(^completion)(void);
@property (strong, nonatomic) NSMutableArray* controllers;

@end

@implementation MRNavigationController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{
		[self setup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public

- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated completion:(void(^)(void))completion
{
	self.completion = completion;
	[super pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController*)navigationController didShowViewController:(UIViewController*)viewController animated:(BOOL)animated
{
	if ([self.controllers containsObject:viewController])
	{
		//This is a pop
		[self.navigationDelegate backButtonPressedFrom:[self.controllers lastObject] to:viewController];
		[self.controllers removeLastObject];
	}
	else
	{
		//This is a push
		[self.controllers addObject:viewController];
	}
	
	if (self.completion)
		self.completion();
	self.completion = nil;
}

#pragma mark - Private

- (void)setup
{
	self.delegate = self;
	self.controllers = [[NSMutableArray alloc] init];
}

@end
