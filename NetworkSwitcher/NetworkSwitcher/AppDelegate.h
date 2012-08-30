//
//  AppDelegate.h
//  NetworkSwitcher
//
//  Created by Jerome Heymonet on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "StatusItemView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate> {
    IBOutlet NSMenu *aMenu;
    NSStatusItem *statusItem;
    StatusItemView *statusItemView;
    
    NSDictionary *primaryInterfaceInfo;
    NSArray *allInterfaces;
    
}
@property (nonatomic, strong) IBOutlet NSMenu *aMenu;

-(IBAction)selectEthernet:(id)sender;
-(IBAction)selectWireless:(id)sender;
-(IBAction)quit:(id)sender;

@end
