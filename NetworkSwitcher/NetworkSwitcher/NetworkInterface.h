//
//  NetworkInterface.h
//  NetworkSwitcher
//
//  Created by Jerome Heymonet on 20/06/12.
//  Copyright (c) 2012 simplegCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkInterface : NSObject {
    NSString *interfaceName;
    NSString *serviceID;
    NSString *interfaceType;
    NSString *hardwareAddress;
    NSString *interfaceSystemName;
    NSString *interfaceImageName;
}

@property (nonatomic, strong) NSString *interfaceName;
@property (nonatomic, strong) NSString *serviceID;
@property (nonatomic, strong) NSString *interfaceType;
@property (nonatomic, strong) NSString *hardwareAddress;
@property (nonatomic, strong) NSString *interfaceSystemName;
@property (nonatomic, strong) NSString *interfaceImageName;

@end
