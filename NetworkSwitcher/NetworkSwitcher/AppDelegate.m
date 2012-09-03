//
//  AppDelegate.m
//  NetworkSwitcher
//
//  Created by Jerome Heymonet on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "NetworkInterface.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface AppDelegate(PrivateMethods)
-(NSDictionary *) getPrimaryInterfaceInfo;
-(CFStringRef) getPrimaryAddress;
-(NSArray *) getAllInterfaces;
-(void) displayMenu;
-(NSArray *) getSortedInterfaceByPrimaryService:(NSString *)primaryService forInterface:(NSArray *)interfaces;
-(void) setMenuItemsWithArray:(NSArray *) content;
@end

@implementation AppDelegate
@synthesize aMenu;

-(void) dealloc {
    
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:24.0];
    statusItemView = [[StatusItemView alloc] initWithStatusItem:statusItem];
    statusItemView.action = @selector(displayMenu);
    statusItemView.target = self;

    [statusItemView setImage:[NSImage imageNamed:@"Status.png"]];
    [statusItemView setAlternateImage:[NSImage imageNamed:@"StatusHighlighted.png"]];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    return NSTerminateNow;
}

-(void) displayMenu {
    [self setMenuItemsWithArray:[self getSortedInterfaceByPrimaryService:[[self getPrimaryInterfaceInfo] objectForKey:@"PrimaryService"] forInterface:[self getAllInterfaces]]];
    [statusItem performSelector:@selector(popUpStatusItemMenu:) withObject:aMenu afterDelay:0.1 inModes:[NSArray arrayWithObjects:NSRunLoopCommonModes, NSDefaultRunLoopMode, nil]];
}

-(IBAction)clickedItem:(NSMenuItem *)sender {
    NSLog(@"Sender %@ %ld",sender, sender.tag);
    NetworkInterface *aInterface = [[self getSortedInterfaceByPrimaryService:[[self getPrimaryInterfaceInfo] objectForKey:@"PrimaryService"] forInterface:[self getAllInterfaces]] objectAtIndex:sender.tag];
    NSLog(@"Interface %@",aInterface);
}

-(IBAction)quit:(id)sender {
    exit(0);
}

-(NSDictionary *) getPrimaryInterfaceInfo {
    NSDictionary *interfaceInfoDict = nil;
    SCDynamicStoreRef	store;
    
    store = SCDynamicStoreCreate(NULL, CFSTR("getPrimaryAddress"), NULL, NULL);
    if (store != NULL) {
        CFStringRef	globalKey;
        CFDictionaryRef	globalDict;
        
		globalKey = SCDynamicStoreKeyCreateNetworkGlobalEntity(NULL, kSCDynamicStoreDomainState, kSCEntNetIPv4);
        
		globalDict = SCDynamicStoreCopyValue(store, globalKey);
        
		CFRelease(globalKey);
        
        if(globalDict != NULL) {
            interfaceInfoDict = [NSDictionary dictionaryWithDictionary:(__bridge NSDictionary*)globalDict];
            CFRelease(globalDict);
        }
        CFRelease(store);
    }
    return interfaceInfoDict;
}

-(NSArray *) getAllInterfaces {
    NSMutableArray *allInts = [[NSMutableArray alloc] init];
    SCPreferencesRef pref = SCPreferencesCreate(NULL, kSCPrefNetworkServices, NULL);
    
    CFArrayRef services = SCNetworkServiceCopyAll(pref);
    
    for( int i = 0; i< CFArrayGetCount(services); i++){
        SCNetworkServiceRef serv = CFArrayGetValueAtIndex(services, i);
        SCNetworkInterfaceRef networkInterface = SCNetworkServiceGetInterface(serv);
        
        NetworkInterface *interface = [[NetworkInterface alloc] init];
        interface.serviceID = (__bridge NSString *)SCNetworkServiceGetServiceID(serv);
        interface.interfaceName = (__bridge NSString *)SCNetworkInterfaceGetLocalizedDisplayName(networkInterface);
        interface.hardwareAddress = (__bridge NSString *)SCNetworkInterfaceGetHardwareAddressString(networkInterface);
        interface.interfaceSystemName = (__bridge NSString *)SCNetworkInterfaceGetBSDName(networkInterface);
        interface.interfaceType = (__bridge NSString *)SCNetworkInterfaceGetInterfaceType(networkInterface);
        
        /* 
         Existing interface type in the framework
         const CFStringRef kSCNetworkInterfaceType6to4;
         const CFStringRef kSCNetworkInterfaceTypeBluetooth;
         const CFStringRef kSCNetworkInterfaceTypeBond;
         const CFStringRef kSCNetworkInterfaceTypeEthernet;
         const CFStringRef kSCNetworkInterfaceTypeFireWire;
         const CFStringRef kSCNetworkInterfaceTypeIEEE80211;
         const CFStringRef kSCNetworkInterfaceTypeIPSec;
         const CFStringRef kSCNetworkInterfaceTypeIrDA;
         const CFStringRef kSCNetworkInterfaceTypeL2TP;
         const CFStringRef kSCNetworkInterfaceTypeModem;
         const CFStringRef kSCNetworkInterfaceTypePPP;
         const CFStringRef kSCNetworkInterfaceTypePPTP;
         const CFStringRef kSCNetworkInterfaceTypeSerial;
         const CFStringRef kSCNetworkInterfaceTypeVLAN;
         const CFStringRef kSCNetworkInterfaceTypeWWAN;
         const CFStringRef kSCNetworkInterfaceTypeIPv4;
         */
        
        
        if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypeBluetooth]){
            interface.interfaceImageName = @"Bluetooth.png";
        } else if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypeBond]){
            interface.interfaceImageName = @"Bond.png";
        } else if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypeEthernet]){
            interface.interfaceImageName = @"Ethernet.png";
        } else if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypeFireWire]){
            interface.interfaceImageName = @"Firewire.png";
        } else if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypeIEEE80211]){
            interface.interfaceImageName = @"Wireless.png";
        } else if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypeIPSec]){
            interface.interfaceImageName = @"IPSec.png";
        } else if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypeIrDA]){
            interface.interfaceImageName = @"IrDA.png";
        } else if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypeL2TP]){
            interface.interfaceImageName = @"L2TP.png";
        } else if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypeModem]){
            interface.interfaceImageName = @"Modem.png";
        } else if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypePPP]){
            interface.interfaceImageName = @"PPP.png";
        } else if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypePPTP]){
            interface.interfaceImageName = @"PPTP.png";
        } else if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypeSerial]){
            interface.interfaceImageName = @"Serial.png";
        } else if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypeVLAN]){
            interface.interfaceImageName = @"VLAN.png";
        } else if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypeWWAN]){
            interface.interfaceImageName = @"WWAN.png";
        } else if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypeIPv4]){
            interface.interfaceImageName = @"IPv4.png";
        } else if([interface.interfaceType isEqualToString:(NSString *)kSCNetworkInterfaceTypeIPSec]){
            interface.interfaceImageName = @"IPSec.png";
        }
        
        [allInts addObject:interface];
        
    }
    
    CFRelease(services);
    CFRelease(pref);
    
    return [NSArray arrayWithArray:allInts];
}

-(CFStringRef) getPrimaryAddress {
	SCDynamicStoreRef	store;
	CFStringRef		address	= NULL;
    
    store = SCDynamicStoreCreate(NULL, CFSTR("getPrimaryAddress"), NULL, NULL);
    if (store != NULL) {
        CFStringRef	globalKey;
        CFDictionaryRef	globalDict;
        
		globalKey = SCDynamicStoreKeyCreateNetworkGlobalEntity(NULL, kSCDynamicStoreDomainState, kSCEntNetIPv4);
        
		globalDict = SCDynamicStoreCopyValue(store, globalKey);
        
		CFRelease(globalKey);
		if (globalDict != NULL) {
			CFStringRef	primaryService;
            
			primaryService = CFDictionaryGetValue(globalDict, kSCDynamicStorePropNetPrimaryService);
            
			if (primaryService != NULL) {
				CFStringRef	ipv4Key;
				CFDictionaryRef	serviceDict;
                
				ipv4Key = SCDynamicStoreKeyCreateNetworkServiceEntity(NULL,
                                                                      kSCDynamicStoreDomainState,
                                                                      primaryService,
                                                                      kSCEntNetIPv4);
				serviceDict = SCDynamicStoreCopyValue(store, ipv4Key);
				CFRelease(ipv4Key);
				if (serviceDict != NULL) {
					CFArrayRef	addresses;
                    
					addresses = CFDictionaryGetValue(serviceDict,
                                                     kSCPropNetIPv4Addresses);
					if ((addresses != NULL) && CFArrayGetCount(addresses) > 0) {
                        
                            // get primary service address!!!
						address = CFArrayGetValueAtIndex(addresses, 0);
						CFRetain(address);
					}
                    
					CFRelease(serviceDict);
				}
			}
			CFRelease(globalDict);
		}
		CFRelease(store);
	}
    
	return address;
}

-(NSArray *) getSortedInterfaceByPrimaryService:(NSString *)primaryService forInterface:(NSArray *)interfaces {
    NSMutableArray *sortedInterfaces = [[NSMutableArray alloc] init];
    for (NetworkInterface *aInterface in interfaces) {
        if([aInterface.serviceID isEqualToString:primaryService]){
            [sortedInterfaces insertObject:aInterface atIndex:0];
        } else {
            [sortedInterfaces addObject:aInterface];
        }
    }
    
    return [NSArray arrayWithArray:sortedInterfaces];
}

-(void) setMenuItemsWithArray:(NSArray *) content {
    [aMenu removeAllItems];
    [aMenu addItem:[[NSMenuItem alloc] initWithTitle:@"Set primary interface" action:nil keyEquivalent:@""]];
    
    [aMenu addItem:[NSMenuItem separatorItem]];
    NSDictionary *primaryInfo = [self getPrimaryInterfaceInfo];
    NSString *primaryService = [primaryInfo objectForKey:@"PrimaryService"];
    for (NetworkInterface *aInterface in content){
        NSMenuItem *aMenuItem = [[NSMenuItem alloc] initWithTitle:aInterface.interfaceName action:@selector(clickedItem:) keyEquivalent:@""];
        [aMenuItem setTag:[content indexOfObject:aInterface]];
        [aMenuItem setImage:[NSImage imageNamed:aInterface.interfaceImageName]];
        if([aInterface.serviceID isEqualToString:primaryService]) {
            NSMenu *subMenu = [[NSMenu alloc] initWithTitle:@"Sub menu"];
            [subMenu addItem:[[NSMenuItem alloc] initWithTitle:aInterface.hardwareAddress action:nil keyEquivalent:@""]];
            [subMenu addItem:[[NSMenuItem alloc] initWithTitle:(__bridge NSString*)[self getPrimaryAddress] action:nil keyEquivalent:@""]];
            [aMenu setSubmenu:subMenu forItem:aMenuItem];
        }
        
        [aMenu addItem:aMenuItem];
    }
    [aMenu addItem:[NSMenuItem separatorItem]];
    [aMenu addItemWithTitle:@"Quit" action:@selector(quit:) keyEquivalent:@""];
}

@end