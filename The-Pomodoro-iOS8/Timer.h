//
//  Timer.h
//  The-Pomodoro-iOS8
//
//  Created by Gamaliel Tellez on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *secondTickNotification = @"secondTickNotification";
static NSString *timerCompleteNotification = @"timerCompleteNotication";
static NSString *newRoundNotification = @"newRoundNotification";

@interface Timer : NSObject

@property (nonatomic, assign) NSInteger minutes;
@property (nonatomic, assign) NSInteger seconds;

+ (Timer *)sharedInstance;
- (void)startTimer;
- (void)cancelTimer;
- (void)prepareForBackground;
- (void)loadFromBackground;
@end
