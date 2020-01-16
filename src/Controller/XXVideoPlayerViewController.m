//
//  XXVideoPlayerViewController.m
//  DTVideoDubbingView
//
//  Created by LG on 2020/1/15.
//

#import "XXVideoPlayerViewController.h"

@interface XXVideoPlayerViewController ()

@end

@implementation XXVideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self cloudAlbumBundleImageNamed:@"1578277138056790.mp4"];
    
}

- (void)cloudAlbumBundleImageNamed:(NSString *)name {
    NSString *mainBundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *bundlePath = [mainBundlePath stringByAppendingString:@"/DTVideoDubbingView.bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    NSLog(@"%@",[resourceBundle pathForResource:name ofType:@""]);
}

@end
