//
//  CGRTCController.m
//  CGRTC
//
//  Created by UFOTO on 2021/5/26.
//

#import "CGRTCController.h"
#import <WebRTC/WebRTC.h>
#import "ViewController.h"
@import SocketIO;

@interface CGRTCController ()
{
    SocketIOClient *socket;
    SocketManager *manager;
}
@end

@implementation CGRTCController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.whiteColor;
    //获取所有的视频设备
    NSArray *devices =[RTCCameraVideoCapturer captureDevices];
    AVCaptureDevice *device = devices[0];
    NSLog(@"%@", device);
    
    [self connect1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    ViewController *vc = [[ViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    [self connect];
}

- (void)connect {
    NSURL *url = [[NSURL alloc] initWithString:@"https://learningrtc.cn"];
    manager = [[SocketManager alloc] initWithSocketURL:url
                                                 config:@{@"log": @YES,
                                                          @"forcePolling":@YES,
                                                          @"forceWebsockets":@YES}];
    socket = manager.defaultSocket;
    [socket connect];
    
    [socket on:@"connect" callback:^(NSArray * data, SocketAckEmitter * ack) {
        NSLog(@"socket connected");
        if (self->socket.status == SocketIOStatusConnected) {
            [self->socket emit:@"join" with:@[@"111111"]];
        }
    }];
    
    [socket on:@"join" callback:^(NSArray * data, SocketAckEmitter * ack) {
        NSString *roomId = [data objectAtIndex:0];
        NSString *userId = [data objectAtIndex:1];
        NSLog(@"socket connected");
    }];
}

- (void)connect1 {
    NSURL* url = [[NSURL alloc] initWithString:@"http://localhost:8080"];
    SocketManager* manager = [[SocketManager alloc] initWithSocketURL:url config:@{@"log": @YES, @"compress": @YES}];
    SocketIOClient* socket = manager.defaultSocket;

    [socket on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected");
    }];

    [socket on:@"currentAmount" callback:^(NSArray* data, SocketAckEmitter* ack) {
        double cur = [[data objectAtIndex:0] floatValue];

        [[socket emitWithAck:@"canUpdate" with:@[@(cur)]] timingOutAfter:0 callback:^(NSArray* data) {
          [socket emit:@"update" with:@[@{@"amount": @(cur + 2.50)}]];
        }];

        [ack with:@[@"Got your currentAmount, ", @"dude"]];
    }];

    [socket connect];
}
@end
