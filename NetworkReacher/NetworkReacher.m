//
//  NetworkReacher.m
//  NetworkReacher
//
//  Created by Dino Alves on 2019/02/18.
//  Copyright © 2019 Alves. All rights reserved.
//

#import <SystemConfiguration/SystemConfiguration.h>
#import "NetworkReacher.h"

@interface NetworkReacher()

@property (nonatomic) SCNetworkReachabilityRef reachability;

@end

@implementation NetworkReacher

- (instancetype)initWithHostName:(NSString *)hostName
{
    if (self = [super init])
    {
        _reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault,
                                                            [hostName cStringUsingEncoding:kCFStringEncodingASCII]);
    }
    
    return self;
}

- (void)start
{
    if ([self setupNetworkReachabilityCallback] == NO)
    {
        NSLog(@"Error: Failed to setup callback");
    }
    
    if ([self setupNetworkReachabilityDispatchQueue] == NO)
    {
        NSLog(@"Error: Failed to setup dispatch queue");
    }
}

- (BOOL)setupNetworkReachabilityCallback
{
    SCNetworkReachabilityContext context = {0, (__bridge void *)self, NULL, NULL, NULL};
    return SCNetworkReachabilitySetCallback(self.reachability, networkReachabilityCallback, &context);
}

- (BOOL)setupNetworkReachabilityDispatchQueue
{
    return SCNetworkReachabilitySetDispatchQueue(self.reachability, dispatch_get_main_queue());
}

void networkReachabilityCallback(SCNetworkReachabilityRef target,
                                 SCNetworkReachabilityFlags flags,
                                 void *info)
{
    NSCAssert(info != NULL, @"info was NULL in networkReachabilityCallback");
    NSCAssert([(__bridge NSObject*)info isKindOfClass:NetworkReacher.class], @"info was wrong class in networkReachabilityCallback");
    
    NetworkReacher* referencedObject = (__bridge NetworkReacher*)info;
    
    switch (flags)
    {
        case kSCNetworkReachabilityFlagsTransientConnection:
            [referencedObject.delegate networkReacherDidUpdate:@"kSCNetworkReachabilityFlagsTransientConnection"];
            break;
        case kSCNetworkReachabilityFlagsReachable:
            [referencedObject.delegate networkReacherDidUpdate:@"kSCNetworkReachabilityFlagsReachable"];
            break;
        case kSCNetworkReachabilityFlagsConnectionRequired:
            [referencedObject.delegate networkReacherDidUpdate:@"kSCNetworkReachabilityFlagsConnectionRequired"];
            break;
        case kSCNetworkReachabilityFlagsConnectionOnTraffic:
            [referencedObject.delegate networkReacherDidUpdate:@"kSCNetworkReachabilityFlagsConnectionOnTraffic"];
            break;
        case kSCNetworkReachabilityFlagsInterventionRequired:
            [referencedObject.delegate networkReacherDidUpdate:@"kSCNetworkReachabilityFlagsInterventionRequired"];
            break;
        case kSCNetworkReachabilityFlagsConnectionOnDemand:
            [referencedObject.delegate networkReacherDidUpdate:@"kSCNetworkReachabilityFlagsConnectionOnDemand"];
            break;
        case kSCNetworkReachabilityFlagsIsLocalAddress:
            [referencedObject.delegate networkReacherDidUpdate:@"kSCNetworkReachabilityFlagsIsLocalAddress"];
            break;
        case kSCNetworkReachabilityFlagsIsDirect:
            [referencedObject.delegate networkReacherDidUpdate:@"kSCNetworkReachabilityFlagsIsDirect"];
            break;
        case kSCNetworkReachabilityFlagsIsWWAN:
            [referencedObject.delegate networkReacherDidUpdate:@"kSCNetworkReachabilityFlagsIsWWAN"];
            break;
        default:
            [referencedObject.delegate networkReacherDidUpdate:@"Default case"];
            break;
    }
}

@end
