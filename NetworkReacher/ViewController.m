//
//  ViewController.m
//  NetworkReacher
//
//  Created by Dino Alves on 2019/02/18.
//  Copyright © 2019 Alves. All rights reserved.
//

#import "ViewController.h"
#import "NetworkReacher.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *networkInfoLabel;
@property (nonatomic, strong) NetworkReacher *networkReacher;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect labelFrame = CGRectMake(115.0f, 150.0f, 200.0f, 30.0f);
    self.networkInfoLabel = [[UILabel alloc] initWithFrame:labelFrame];
    self.networkInfoLabel.text = @"Hello World";
    [self.view addSubview:self.networkInfoLabel];
    
    self.networkReacher = [[NetworkReacher alloc] initWithHostName:@"www.google.com"];
    self.networkReacher.delegate = self;
    [self.networkReacher start];
}


- (void)networkReacherDidUpdate:(nonnull NSString *)description
{
    NSLog(@"networkReacherDidUpdate: %@", description);
}

@end
