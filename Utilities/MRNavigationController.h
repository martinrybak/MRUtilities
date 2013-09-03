//
//  MRNavigationController.h
//  Utilities
//
//  Created by Martin Rybak on 9/3/13.
//  Copyright (c) 2013 Martin Rybak. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MRNavigationControllerDelegate

- (void)backButtonPressedFrom:(UIViewController*)from to:(UIViewController*)to;

@end

@interface MRNavigationController : UINavigationController <UINavigationControllerDelegate>

- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated completion:(void (^)(void))completion;
@property (weak, nonatomic) id<MRNavigationControllerDelegate> navigationDelegate;

@end
