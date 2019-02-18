//
//  NetworkReacherable.h
//  NetworkReacher
//
//  Created by Dino Alves on 2019/02/18.
//  Copyright © 2019 Alves. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@protocol NetworkReacherable <NSObject>

- (void)networkReacherDidUpdate:(NSString *)description;

@end

NS_ASSUME_NONNULL_END
