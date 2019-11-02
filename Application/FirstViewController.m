//
//  FirstViewController.m
//  Application
//
//  Created by nslog on 2019/10/15.
//  Copyright © 2019 nslog. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"CACurrentMediaTime: %f", CACurrentMediaTime());
    NSLog(@"CFAbsoluteTimeGetCurrent: %f", CFAbsoluteTimeGetCurrent());
    
    UILabel *label = [self.view viewWithTag:1001];
    label.text = [NSString stringWithFormat:@"CACurrentMediaTime: %f", CACurrentMediaTime()];
}


@end
