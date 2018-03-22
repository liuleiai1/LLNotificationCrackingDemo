//
//  LLTwoViewController.m
//  LLNotificationCracking
//
//  Created by 迦南 on 2017/9/24.
//  Copyright © 2017年 迦南. All rights reserved.
//

#import "LLTwoViewController.h"
#import "LLNotification.h"

@interface LLTwoViewController ()

@end

@implementation LLTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSDictionary *dict = @{@"name" : @"ray", @"age" : @18};
    [[LLNotificationCenter defaultCenter] postNotificationName:@"newObject" object:self userInfo:dict];
}

@end
