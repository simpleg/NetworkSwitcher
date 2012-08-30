//
//  NetworkInterface.m
//  NetworkSwitcher
//
//  Created by Jerome Heymonet on 20/06/12.
//  Copyright (c) 2012 simplegCorp. All rights reserved.
//

#import "NetworkInterface.h"

@implementation NetworkInterface

@synthesize interfaceName;
@synthesize serviceID;
@synthesize interfaceType;
@synthesize hardwareAddress;
@synthesize interfaceSystemName;

-(NSString *)description {
    return [NSString stringWithFormat:@"interface name %@ serviceID %@ interfaceType %@ hardware address %@ interface system name %@", interfaceName, serviceID, interfaceType, hardwareAddress, interfaceSystemName];
}

@end
