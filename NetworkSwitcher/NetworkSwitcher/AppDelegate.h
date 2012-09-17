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
    IBOutlet NSWindow *prefWindow;
    IBOutlet NSButton *launchAtStartupCheckbox;
    IBOutlet NSTextField *currentVersionTextField;
    IBOutlet NSTextField *sourceLinkTextField;
}
@property (nonatomic, strong) IBOutlet NSMenu *aMenu;
@property (nonatomic, strong) IBOutlet NSWindow *prefWindow;
@property (nonatomic, strong) IBOutlet NSButton *launchAtStartupCheckbox;
@property (nonatomic, strong) IBOutlet NSTextField *currentVersionTextField;
@property (nonatomic, strong) IBOutlet NSTextField *sourceLinkTextField;

-(IBAction)checkBoxClicked:(id)sender;

@end
