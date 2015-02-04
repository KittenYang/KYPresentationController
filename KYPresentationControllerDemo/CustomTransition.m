//
//  CustomTransition.m
//  KYPresentationControllerDemo
//
//  Created by Kitten Yang on 2/1/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "CustomTransition.h"
#import "ViewController.h"
#import "SecondViewController.h"

@interface CustomTransition()

@property(nonatomic,assign)BOOL isPresenting;
@property(nonatomic,strong)UIView *containerView;

@end

@implementation CustomTransition


//定义一个类的 property,用来区别我们到底现在是 呈现 还是 消失

-(id)initWithBool:(BOOL)ispresenting{
    self = [super init];
    if (self) {
        self.isPresenting = ispresenting;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    if (self.isPresenting) {


        SecondViewController *toVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

        self.containerView = [transitionContext containerView];
        
        //设定presented view 一开始的位置，在屏幕下方
        CGRect initialframe = [transitionContext finalFrameForViewController:toVC];
        CGRect startframe = CGRectOffset(initialframe, 0, initialframe.size.height);
        toView.frame = startframe;
        

//        [self.containerView addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear animations:^{

            //secondviewcontroller 滑上来
            toView.frame = initialframe;
            
        } completion:^(BOOL finished) {
            if (finished) {
    
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }
        }];
    }else{


        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        self.containerView = [transitionContext containerView];
        

        [self.containerView addSubview:toView];
        
        
        // 添加一个动画，让要消失的 view 向下移动，离开屏幕
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear animations:^{
            
            //secondviewcontroller 滑下去
            CGRect finalframe = fromView.frame;
            finalframe.origin.y = self.containerView.bounds.size.height;
            fromView.frame = finalframe;
            
        } completion:^(BOOL finished) {
            if (finished) {
                
                [transitionContext completeTransition:![transitionContext transitionWasCancelled] || ![transitionContext isInteractive]];
            }
            
        }];
    
    }
    
    
}


@end
