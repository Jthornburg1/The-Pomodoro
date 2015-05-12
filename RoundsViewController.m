//
//  RoundsViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Gamaliel Tellez on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsViewController.h"
#import "RoundsController.h"
#import "TimerViewController.h"
#import "Timer.h"

static NSString *cellIdentifier = @"cellIdentifier";
@interface RoundsViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation RoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView dataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [RoundsController sharedInstance].roundTimes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", [RoundsController sharedInstance].roundTimes[indexPath.row]];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSArray *roundsArray = [RoundsController sharedInstance].roundTimes;
    NSNumber *minutes = roundsArray[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%li minutes", (long)[minutes integerValue]];
    
    
    return cell;
}
#pragma mark-tableView delegateMethod

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [RoundsController sharedInstance].currentRound = indexPath.row;
    [[RoundsController sharedInstance] roundSelected];
    [[Timer sharedInstance] cancelTimer];
}

#pragma mark - Notifications
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //here is where we initiate or instance or we do anything we need to
        [self  registerForNotifications];
    }
    return self;
}

- (void)registerForNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(roundComplete) name:timerCompleteNotification object:nil];
}

- (void)unregisterForNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)dealloc {
    
    [self unregisterForNotifications];
}


-(void)roundComplete {
    if ([RoundsController sharedInstance].currentRound < [RoundsController sharedInstance].roundTimes.count - 1) {
        [RoundsController sharedInstance].currentRound++;
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[RoundsController sharedInstance].currentRound inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [[RoundsController sharedInstance] roundSelected];
    } else {
        [RoundsController sharedInstance].currentRound = 0;
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[RoundsController sharedInstance].currentRound inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [[RoundsController sharedInstance] roundSelected];
    }
}










@end
