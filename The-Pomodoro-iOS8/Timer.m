//
//  Timer.m
//  The-Pomodoro-iOS8
//
//  Created by Gamaliel Tellez on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Timer.h"
@import  UIKit;

@interface Timer ()

@property (nonatomic, assign) BOOL isOn;
@property (nonatomic, strong) NSDate *expirationDate;

@end

@implementation Timer


+(Timer *)sharedInstance{
    static Timer *sharedInstance = nil;
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    sharedInstance = [[Timer alloc]init];
    
});
    return sharedInstance;
}


-(void)startTimer {
    self.isOn = YES;
    [self checkActive];
    
    NSTimeInterval timerLenght = self.minutes * 60 + self.seconds;
    self.expirationDate = [NSDate dateWithTimeIntervalSinceNow:timerLenght];
    
    UILocalNotification *newLocalNotification = [[UILocalNotification alloc]init];
    newLocalNotification.fireDate = self.expirationDate;
    newLocalNotification.timeZone = [NSTimeZone defaultTimeZone];
    newLocalNotification.soundName = UILocalNotificationDefaultSoundName;
    newLocalNotification.alertBody = @"Time is up!!!";
    [[UIApplication sharedApplication] scheduleLocalNotification:newLocalNotification];
    
}

- (void)endTimer {
    self.isOn = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:timerCompleteNotification object:nil];
}

- (void)decreaseSecond{
    if (self.seconds > 0) {
        self.seconds--;
        [[NSNotificationCenter defaultCenter] postNotificationName:secondTickNotification object:nil];
    } else if (self.seconds == 0 && self.minutes > 0) {
        self.seconds = 59;
        self.minutes--;
        [[NSNotificationCenter defaultCenter] postNotificationName:secondTickNotification object:nil];
    } else {
        [self endTimer];
    }
}
- (void)checkActive {
    if (self.isOn == YES) {
        [self decreaseSecond];
        [self performSelector:@selector(checkActive) withObject:nil afterDelay:1.0];
    }
}

-(void)cancelTimer {
    self.isOn = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}
- (void)prepareForBackground {
    [[NSUserDefaults standardUserDefaults] setObject:self.expirationDate forKey:@"expirationDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)loadFromBackground {
    self.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"expirationDate"];
    NSTimeInterval seconds = [self.expirationDate timeIntervalSinceNow];
    self.minutes = seconds / 60;
    self.seconds = seconds - (self.minutes * 60);
    
}



@end
