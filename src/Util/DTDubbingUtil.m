//
//  DTDubbingUtil.m
//  Pods-DTVideoDubbingViewDemo
//
//  Created by LG on 2020/1/14.
//

#import "DTDubbingUtil.h"

#define kRecordAudioFile @"myRecord.caf"
@interface DTDubbingUtil ()<AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder *audioRecorder;//音频录音机

@property (nonatomic, strong) NSString *filePath;

@property (nonatomic, strong) NSDictionary  *dubbingSetting; // 录音配置

@property (nonatomic, strong) AVAudioSession *session;

@end

@implementation DTDubbingUtil


- (instancetype)initWithUrlPath:(NSString *)urlPath {
    if(self = [super init]){

        [self audioRecorder];
        [self.audioRecorder prepareToRecord];
        
        AVAudioSession *session =[AVAudioSession sharedInstance];
        NSError *sessionError;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        
        if (session == nil) {
            NSLog(@"Error creating session: %@",[sessionError description]);
        }else{
            [session setActive:YES error:nil];
        }
        self.session = session;
    }
    return self;
}

#pragma mark - private

- (void) start {
    [self.audioRecorder record];
}

- (void) pause {
     if (self.audioRecorder.isRecording) {
          [self.audioRecorder pause];
    }
}

- (void)rest {
    if (self.audioRecorder !=nil && !self.audioRecorder.isRecording) {
        [self.audioRecorder record];
    }
}

- (void) stop {
    [self.audioRecorder stop];
}

- (CGFloat) updateMeters {
    [self.audioRecorder updateMeters];//更新测量值
    float power= [self.audioRecorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
    CGFloat progress=(1.0/160.0)*(power+160.0);
    return progress;
}

#pragma mark - AVAudioRecorderDelegate

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"录音完成!");
}

#pragma mark - setter/getter

- (AVAudioRecorder *)audioRecorder {
    if(!_audioRecorder){
        NSError *error = nil;
        NSString *filePath = [self getSavePath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL ret = [fileManager removeItemAtPath:filePath error:nil];
        NSLog(@"file path:%@   %@",filePath ,ret ? @"Y" : @"n");
        NSURL *url=[NSURL fileURLWithPath:filePath];
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:self.dubbingSetting error:&error];
        _audioRecorder.delegate = self;
        _audioRecorder.meteringEnabled = YES;
        if(error){
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}


- (NSDictionary *)dubbingSetting {
    
    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(11025.0) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(2) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    
    return dicM;
}

/** * 取得录音文件保存路径 * * @return 录音文件路径 */
-(NSString *)getSavePath{
    
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:kRecordAudioFile];

    return urlStr;
}

@end
