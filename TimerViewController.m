//
//  TimerViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Gamaliel Tellez on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TimerViewController.h"
#import "Timer.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *timerButton;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)timerButtonTapped:(id)sender {
    
    [[Timer sharedInstance]startTimer];
    self.timerButton.enabled = NO;
    
}

//custome init method
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //here is where we initiate or instance or we do anything we need to
        [self  registerForNotifications];
    }
    return self;
}




- (void)updateTimerLabel {
    

    self.timerLabel.text = [self timerStringWithMinutes:[Timer sharedInstance].minutes andSeconds:[Timer sharedInstance].seconds];

}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTimerLabel) name:secondTickNotification object:nil];
    
}

- (NSString *)timerStringWithMinutes:(NSInteger)minutes andSeconds:(NSInteger)seconds
{
    NSString *timerString;
    
    if (minutes >= 10)
    {
        timerString = [NSString stringWithFormat:@"%li:", (long)minutes];
    }
    else
    {
        timerString = [NSString stringWithFormat:@"0%li:", (long)minutes];
    }
    
    if (seconds >= 10)
    {
        timerString = [timerString stringByAppendingString:[NSString stringWithFormat:@"%li", (long)seconds]];
    }
    else
    {
        timerString = [timerString stringByAppendingString:[NSString stringWithFormat:@"0%li", (long)seconds]];
    }
    
    return timerString;
}

- (void)unregisterForNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)dealloc {
    [self unregisterForNotifications];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
