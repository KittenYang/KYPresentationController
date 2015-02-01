//
//  CustomTransition.h
//  KYPresentationControllerDemo
//
//  Created by Kitten Yang on 2/1/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomTransition : NSObject<UIViewControllerAnimatedTransitioning>

-(id)initWithBool:(BOOL)ispresenting;

@end
