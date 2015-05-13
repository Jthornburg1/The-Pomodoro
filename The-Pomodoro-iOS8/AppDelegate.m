//
//  AppDelegate.m
//  The-Pomodoro-iOS8
//
//  Created by Taylor Mott on 18.2.2015.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "AppDelegate.h"
#import "TimerViewController.h"
#import "RoundsViewController.h"
#import "AppearanceManager.h"
#import "Timer.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    TimerViewController *timerVC = [[TimerViewController alloc] init];
    timerVC.tabBarItem.title = @"Timer";
    timerVC.tabBarItem.image = [UIImage imageNamed:@"timer"];
    
    RoundsViewController *roundVC = [[RoundsViewController alloc] init];
    roundVC.tabBarItem.title = @"Rounds";
    roundVC.tabBarItem.image = [UIImage imageNamed:@"rounds"];
    UINavigationController *roundNavController = [[UINavigationController alloc] initWithRootViewController:roundVC];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[timerVC, roundNavController];
    
    self.window.rootViewController = tabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [AppearanceManager appearanceManager];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[Timer sharedInstance] prepareForBackground];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[Timer sharedInstance] loadFromBackground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
//    
//    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge |
//                                                       UIRemoteNotificationTypeSound |
//                                                       UIRemoteNotificationTypeAlert)
//                                                                                        categories:nil]];    }
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil]];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    UIAlertController *timeUpAlert = [UIAlertController alertControllerWithTitle:@"Timer is Up" message:@"You Did It" preferredStyle:UIAlertControllerStyleAlert];
    
    
        UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dimiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
    [timeUpAlert addAction:dismissAction];
    
        UIAlertAction *startNextRound = [UIAlertAction actionWithTitle:@"New Round" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[Timer sharedInstance] startTimer];
        }];
    [timeUpAlert addAction:startNextRound];
    
    [self.window.rootViewController presentViewController:timeUpAlert animated:YES completion:nil];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
