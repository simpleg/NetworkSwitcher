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
}
@property (nonatomic, strong) IBOutlet NSMenu *aMenu;

@end
