//
//  AppDelegate.m
//  TryCrash
//
//  Created by wangjianfei on 16/2/27.
//  Copyright © 2016年 wangjianfei. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    return YES;
}

@end
