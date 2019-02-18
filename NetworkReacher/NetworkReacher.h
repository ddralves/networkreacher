//
//  NetworkReacher.h
//  NetworkReacher
//
//  Created by Dino Alves on 2019/02/18.
//  Copyright © 2019 Alves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkReacherable.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkReacher : NSObject

@property (nonatomic, strong) id<NetworkReacherable> delegate;

- (instancetype)initWithHostName:(NSString *)hostName;
- (instancetype)init NS_UNAVAILABLE;

- (void)start;

@end

NS_ASSUME_NONNULL_END
