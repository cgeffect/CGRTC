//
//  CGRTCClient.m
//  CGRTC
//
//  Created by 王腾飞 on 2021/5/30.
//

#import "CGRTCClient.h"
#import <WebRTC/WebRTC.h>

@implementation CGRTCClient

//创建PC Factory
- (RTCPeerConnectionFactory *)createPeerConnectionFactory {
    RTCDefaultVideoDecoderFactory *decoderFactory = [[RTCDefaultVideoDecoderFactory alloc] init];
    RTCDefaultVideoEncoderFactory *encoderFactory = [[RTCDefaultVideoEncoderFactory alloc] init];
    RTCPeerConnectionFactory *factory = [[RTCPeerConnectionFactory alloc] initWithEncoderFactory:encoderFactory decoderFactory:decoderFactory];
    return factory;

}
@end
