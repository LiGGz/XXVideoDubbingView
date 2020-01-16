//
//  XXVideoDubbingViewController.m
//  Pods-DTVideoDubbingViewDemo
//
//  Created by LG on 2020/1/14.
//

#import "XXVideoDubbingViewController.h"
#import "DTDubbingUtil.h"
#import "XXVideoPlayerViewController.h"

@interface XXVideoDubbingViewController ()


@property (weak, nonatomic)  UIButton *recordingButton;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) DTDubbingUtil *dubbingUtil;

@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@property (weak, nonatomic)  UIButton *rest;

@property (weak, nonatomic)  UIButton *stop;

@property (weak, nonatomic)  UIButton *autuobutton;

@property (nonatomic, strong) UIButton *gotoVideoButton;
@end

@implementation XXVideoDubbingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 0;
    [self setupUI];
    [self dubbingUtil];
}

- (void) clickRecording:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(sender.selected){
        [self.dubbingUtil start];
        [self timer];
    }else{
        [self.dubbingUtil stop];
        [self removeTime];
        self.count = 0;
    }
}
- (void)pause:(id)sender {
    [self.dubbingUtil pause];
    self.recordingButton.selected = YES;
    [self removeTime];
}
- (void)continues:(id)sender {
    [self.dubbingUtil rest];
    [self timer];
    self.recordingButton.selected = YES;
}

- (void) getAutuoinform {
    NSString *filePath = self.dubbingUtil.getSavePath;
    AVURLAsset *audioAsset1 = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:filePath]];
    NSLog(@"%@",audioAsset1);
    AVAssetTrack *audioAssetTrack1 = [[audioAsset1 tracksWithMediaType:AVMediaTypeAudio] firstObject];
    NSLog(@"%@",audioAssetTrack1);
}

- (void) gotoVideoPlayer {
    
    XXVideoPlayerViewController *videoPlayer = [[XXVideoPlayerViewController alloc] init];
    [self presentViewController:videoPlayer animated:YES completion:nil];
}

- (NSTimer *)timer {
    if(!_timer){
        if (@available(iOS 10.0, *)) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                self.count ++ ;
                self.timeLabel.text = [NSString stringWithFormat:@"%@",[self getMMSSFromSS:[NSString stringWithFormat:@"%ld",(long)self.count]]];
                CGFloat progress = [self.dubbingUtil updateMeters];
                [self.progress setProgress:progress];
            }];
        } else {

        }
    }
    return _timer;
}

- (void) removeTime {
    [self.timer invalidate];
    self.timer = nil;
}


-(NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger millisecond = [totalTime integerValue];
    
    NSInteger seconds = millisecond / 10;
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%ld",seconds/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@分钟%@秒",str_minute,str_second];
    
    NSLog(@"format_time : %@",format_time);
    
    return format_time;
}

- (DTDubbingUtil *)dubbingUtil {
    if(!_dubbingUtil){
        _dubbingUtil = [[DTDubbingUtil alloc] initWithUrlPath:@""];
    }
    return _dubbingUtil;
}

- (UIButton *) makeCreateButton:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.backgroundColor = [UIColor redColor];
    button.backgroundColor = [UIColor redColor];
    button .layer.cornerRadius = 22;
    button.layer.masksToBounds = YES;
    [self.view addSubview:button];
    return button;
}



- (void) setupUI {
      
       CGFloat width = [UIScreen mainScreen].bounds.size.width;
       CGFloat height = [UIScreen mainScreen].bounds.size.height;
       self.autuobutton = [self makeCreateButton:@"获取音轨"];
       self.rest = [self makeCreateButton:@"继续"];
       self.stop = [self makeCreateButton:@"暂停"];
       self.recordingButton = [self makeCreateButton:@"开始录制"];
       self.gotoVideoButton = [self makeCreateButton:@"合成视频"];
       [self.recordingButton setTitle:@"结束" forState:UIControlStateSelected];
    

    self.gotoVideoButton.frame = CGRectMake((width - 136) / 2, height - 44 - 44, 136, 44);
       self.autuobutton.frame = CGRectMake((width - 136) / 2, height - 100 - 44 , 136, 44);
       self.rest.frame = CGRectMake((width - 136) / 2, CGRectGetMinY(self.autuobutton.frame) - 60, 136, 44);
       self.stop.frame = CGRectMake((width - 136) / 2,  CGRectGetMinY(self.rest.frame) - 60, 136, 44);
       self.recordingButton.frame = CGRectMake((width - 136) / 2,  CGRectGetMinY(self.stop.frame) - 60, 136, 44);

       
      [self.recordingButton addTarget:self action:@selector(clickRecording:) forControlEvents:UIControlEventTouchUpInside];
     [self.autuobutton addTarget:self action:@selector(getAutuoinform) forControlEvents:UIControlEventTouchUpInside];
     [self.stop addTarget:self action:@selector(pause:) forControlEvents:UIControlEventTouchUpInside];
     [self.rest addTarget:self action:@selector(continues:) forControlEvents:UIControlEventTouchUpInside];
     [self.gotoVideoButton addTarget:self action:@selector(gotoVideoPlayer) forControlEvents:UIControlEventTouchUpInside];
   
}


@end
