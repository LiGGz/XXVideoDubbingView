//
//  XXVideoDubbingViewController.m
//  Pods-DTVideoDubbingViewDemo
//
//  Created by LG on 2020/1/14.
//

#import "XXVideoDubbingViewController.h"

@interface XXVideoDubbingViewController ()

@property (weak, nonatomic) IBOutlet UIButton *recordingButton;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation XXVideoDubbingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.recordingButton.layer.cornerRadius = 22;
    self.recordingButton.layer.masksToBounds = YES;
    
}


@end
