//
//  SecondViewController.m
//  KYPresentationControllerDemo
//
//  Created by Kitten Yang on 2/1/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "SecondViewController.h"
#import "CustomTransition.h"
#import "CustomPresentation.h"

@interface SecondViewController ()
@property (strong, nonatomic) IBOutlet UIView *secondView;
@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation SecondViewController{
    UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;
    CGFloat percent;
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate  = self;

    }
    return self;
}


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate  = self;

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGes:)];
    [self.view addGestureRecognizer:pan];
}

-(void)panGes:(UIPanGestureRecognizer *)gesture{
    CGFloat yOffset = [gesture translationInView:self.view].y;
    percent =  yOffset / 1900;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        //这句必须加上！！
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (gesture.state == UIGestureRecognizerStateChanged){
        [percentDrivenInteractiveTransition updateInteractiveTransition:percent];
    }else if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded){
        if (percent > 0.06) {
            [percentDrivenInteractiveTransition finishInteractiveTransition];
        }else{
            [percentDrivenInteractiveTransition cancelInteractiveTransition];
            [self shakeit:self.view];
        }
        //这句也必须加上！！
        percentDrivenInteractiveTransition = nil;
    }
}

-(void)shakeit:(UIView *)view{
    
    CGPoint viewPosition = view.layer.position;
    CGPoint startPosition = CGPointMake(viewPosition.x + 10, viewPosition.y);
    CGPoint endPosition   = CGPointMake(viewPosition.x - 10, viewPosition.y);
    
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    shakeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    shakeAnimation.fromValue = [NSValue valueWithCGPoint:startPosition];
    shakeAnimation.toValue   = [NSValue valueWithCGPoint:endPosition];
    shakeAnimation.autoreverses = YES;
    shakeAnimation.duration = 0.06;
    shakeAnimation.repeatCount = 2;
    
    [view.layer addAnimation:shakeAnimation forKey:@"shakeit"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - <UIViewControllerTransitioningDelegate>
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){
    CustomPresentation *presentation = [[CustomPresentation alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    return presentation;
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    CustomTransition * present = [[CustomTransition alloc]initWithBool:YES];
    return present;
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    CustomTransition * present = [[CustomTransition alloc]initWithBool:NO];
    return present;

}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    if (animator) {
        return percentDrivenInteractiveTransition;
    }else{
        return nil;
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
