//
//  DotzuX.swift
//  demo
//
//  Created by liman on 26/11/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "NetworkHelper.h"
#import "SessionProtocol_default.h"
#import "SessionProtocol_ephemeral.h"

@interface NetworkHelper()

@end

@implementation NetworkHelper

+ (instancetype)shared
{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)enable
{
    self.isEnable = YES;
    [NSURLProtocol registerClass:[SessionProtocol_default class]];
    [NSURLProtocol registerClass:[SessionProtocol_ephemeral class]];
}

- (void)disable
{
    self.isEnable = NO;
    [NSURLProtocol unregisterClass:[SessionProtocol_default class]];
    [NSURLProtocol unregisterClass:[SessionProtocol_ephemeral class]];
}

@end
