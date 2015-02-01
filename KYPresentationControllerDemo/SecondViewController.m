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

@end

@implementation SecondViewController


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
    // Do any additional setup after loading the view.
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
