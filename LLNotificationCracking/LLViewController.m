//
//  LLViewController.m
//  LLNotificationCracking
//
//  Created by 迦南 on 2017/9/24.
//  Copyright © 2017年 迦南. All rights reserved.
//

#import "LLViewController.h"
#import "LLTwoViewController.h"
#import "LLNotification.h"

@interface LLViewController ()

@end

@implementation LLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor greenColor];
    
    [[LLNotificationCenter defaultCenter] addObserver:self selector:@selector(getOldNotificationValue:) name:@"oldObject" object:nil];
}

- (void)getOldNotificationValue:(NSNotification *)noti {
    
    NSLog(@"%@", noti);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    LLTwoViewController *vc = [[LLTwoViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
