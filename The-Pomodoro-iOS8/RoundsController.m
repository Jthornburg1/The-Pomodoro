//
//  RoundsController.m
//  The-Pomodoro-iOS8
//
//  Created by Gamaliel Tellez on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsController.h"
#import "Timer.h"

@interface RoundsController ()
@property (nonatomic,strong) NSArray *roundTimes;


@end


@implementation RoundsController

+ (instancetype)sharedInstance{
    static RoundsController *sharedInstance = nil;
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    sharedInstance = [[RoundsController alloc]init];
});
    return sharedInstance;
}

- (NSArray *) roundTimes {
    
    return @[@25, @1, @25, @5, @25, @5, @25, @15];
}

- (void)roundSelected {
    [Timer sharedInstance].minutes = [[self roundTimes][self.currentRound] integerValue];
    [Timer sharedInstance].seconds = 0;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:newRoundNotification object:nil];
}

//In the implementaion file, override the roundTimes getter method and return this array

@end
