//
//  Timer.m
//  The-Pomodoro-iOS8
//
//  Created by Gamaliel Tellez on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Timer.h"

@interface Timer ()

@property (nonatomic, assign) BOOL isOn;

@end

@implementation Timer

-(void)startTimer {
    self.isOn = YES;
    [self checkActive];
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
    
}



@end
