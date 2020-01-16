//
//  DTDubbingUtil.h
//  Pods-DTVideoDubbingViewDemo
//
//  Created by LG on 2020/1/14.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface DTDubbingUtil : NSObject

- (instancetype)initWithUrlPath:(NSString *)urlPath;


- (void) start;

- (void) pause;

- (void) rest;

- (void) stop;

- (CGFloat) updateMeters;

-(NSString *)getSavePath;


@end

NS_ASSUME_NONNULL_END
