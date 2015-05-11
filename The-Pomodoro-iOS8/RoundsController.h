//
//  RoundsController.h
//  The-Pomodoro-iOS8
//
//  Created by Gamaliel Tellez on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoundsController : NSObject
@property (nonatomic,strong,readonly) NSArray *roundTimes;
@property (nonatomic) NSInteger currentRound;


+ (instancetype)sharedInstance;

- (NSArray *) roundTimes;
@end
