//
//  ViewController.m
//  tiantianzhibo
//
//  Created by michael on 31/7/2016.
//  Copyright © 2016 michael. All rights reserved.
//

#import "ViewController.h"



#import <GPUImage/GPUImageView.h>
#import <GPUImage/GPUImageFilter.h>
#import <AVFoundation/AVFoundation.h>
#import <GPUImage/GPUImageVideoCamera.h>
#import <GPUImage/GPUImageRawDataOutput.h>

#import "GDLRawDataOutput.h"
#import "GPUImageMovieWriter.h"
#import "GPUImageLanczosResamplingFilter.h"
#import "GPUImageBeautifyFilter.h"
#import "GDLFilterUtil.h"
#import <AssetsLibrary/ALAssetsLibrary.h>


#import <IJKMediaFramework/IJKMediaFramework.h>




@interface ViewController ()



@property (atomic, strong) NSURL *url;
@property (atomic, retain) id <IJKMediaPlayback> player;
@property (weak, nonatomic) UIView *PlayerView;

@property (weak, nonatomic) UIView *overlapView;


@end

@implementation ViewController


GPUImageVideoCamera *_videoCamera;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self startPlay];
}


- (IBAction)CaptureVideo:(id)sender {
    
    
    //  [self startCapture];
    
    [self startPlay];
    
}


-(void)viewWillAppear:(BOOL)animated{
    if (![self.player isPlaying]) {
        [self.player prepareToPlay];
    }
}


/** 加载网络视频,并增加到主视图上去  **/
-(void)startPlay{
    //网络视频
    //    self.url = [NSURL URLWithString:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    //    _player = [[IJKAVMoviePlayerController alloc] initWithContentURL:self.url];
    
    //直播视频
      self.url = [NSURL URLWithString:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"];
    
    
    /** config PlayerView **/
    UIView *displayView = [[UIView alloc] initWithFrame:self.view.bounds];
    //UIView *displayView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 180)];
    displayView.backgroundColor = [UIColor greenColor];
    self.PlayerView = displayView;
    
    /** config videoView **/
    // self.url = [NSURL URLWithString:@"rtmp://192.168.0.112:1935/live1/test2"];
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:nil];
    UIView *videoView = [self.player view];
    videoView.frame = self.PlayerView.bounds;
    videoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    
    
    /** put videoView into PlayerView   **/
    [self.PlayerView insertSubview:videoView atIndex:1];
    
    [self installMovieNotificationObservers];
    
    /**  put PlayerView into current view  **/
    [self.view addSubview:self.PlayerView];
    
    
    /* 下面这段代码用于控制播放器的播放、暂停
    if (![self.player isPlaying]) {
        [self.player play];
    }else{
        [self.player pause];
    } */
    
}

/*  开始捕获视频 */
-(void)startCapture{
    
    
    _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionFront];
    _videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    _videoCamera.frameRate = 20;
    
    CGSize viewSize = self.view.frame.size;
    GPUImageView *filteredVideoView = [[GPUImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, viewSize.width, viewSize.height)];
    [self.view addSubview:filteredVideoView];
    [_videoCamera addTarget:filteredVideoView];
    
    CGSize captureSize = CGSizeMake(16 * 45, 1280);
    CGSize rtmpSize = CGSizeMake(16 * 23, 640);
    GPUImageFilter *filter = [[GPUImageLanczosResamplingFilter alloc] init];
    [filter forceProcessingAtSize:rtmpSize];
    GDLRawDataOutput *rtmpOutput = [[GDLRawDataOutput alloc] initWithVideoCamera:_videoCamera withImageSize:rtmpSize];
    [_videoCamera addTarget:filter];
    [filter addTarget:rtmpOutput];
    
    // 同时备份视频到本地文件
    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
    unlink([pathToMovie UTF8String]); // If a file already exists, AVAssetWriter won't let you record new frames, so delete the old movie
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    GPUImageMovieWriter *movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:captureSize];
    movieWriter.encodingLiveVideo = YES;
    [_videoCamera addTarget:movieWriter];
    
    // 是否开启美颜
    BOOL useSkinSmoothing = NO;
    if (useSkinSmoothing) {
        GPUImageBeautifyFilter *beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
        [GDLFilterUtil insertFilter:beautifyFilter before:filteredVideoView toChain:_videoCamera];
    }
    
    [_videoCamera startCameraCapture];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void) {
        _videoCamera.audioEncodingTarget = movieWriter;
        //  [movieWriter startRecording];
        //   [rtmpOutput startUploadStreamWithURL:@"rtmp://a.rtmp.youtube.com/live2" andStreamKey:@"323c-p07x-2g2e-c57k"];
        
        [rtmpOutput startUploadStreamWithURL:@"rtmp://192.168.0.108:1935/live1" andStreamKey:@"test2"];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 120.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void) {
            [_videoCamera removeTarget:movieWriter];
            _videoCamera.audioEncodingTarget = nil;
            //     [movieWriter finishRecording];
            NSLog(@"Movie completed");
            
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:movieURL]) {
                [library writeVideoAtPathToSavedPhotosAlbum:movieURL completionBlock:^(NSURL *assetURL, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"
                                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                        } else {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Saved To Photo Album"
                                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                        }
                    });
                }];
            }
        });
    });
    
}


- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}
- (void)moviePlayBackFinish:(NSNotification*)notification {
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}
- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}
- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    switch (_player.playbackState) {
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
            
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}
#pragma Install Notifiacation
- (void)installMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
    
}
- (void)removeMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
