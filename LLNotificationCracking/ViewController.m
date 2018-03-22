//
//  ViewController.m
//  LLNotificationCracking
//
//  Created by 迦南 on 2017/9/23.
//  Copyright © 2017年 迦南. All rights reserved.
//

#import "ViewController.h"
#import "LLViewController.h"
#import "LLNotification.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[LLNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotificationValue:) name:@"newObject" object:nil];
}

- (void)getNotificationValue:(NSNotification *)noti {
    
    NSLog(@"%@", noti);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    LLViewController *vc = [[LLViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
