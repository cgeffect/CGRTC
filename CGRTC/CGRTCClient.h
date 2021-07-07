//
//  CGRTCClient.h
//  CGRTC
//
//  Created by 王腾飞 on 2021/5/30.
//

#import <Foundation/Foundation.h>
#import <WebRTC/RTCPeerConnection.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGRTCClient : NSObject
@property(nonatomic, strong) RTCPeerConnectionFactory *factory;

@end

NS_ASSUME_NONNULL_END
