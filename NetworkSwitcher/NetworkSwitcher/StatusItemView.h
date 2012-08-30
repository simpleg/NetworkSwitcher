//
//  StatusItemView.h
//  NetworkSwitcher
//
//  Created by Jerome Heymonet on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StatusItemView : NSView {
@private
    NSImage *image;
    NSImage *alternateImage;
    NSStatusItem *statusItem;
    BOOL isHighlighted;
    SEL action;
    __unsafe_unretained id target;
}

-(id) initWithStatusItem:(NSStatusItem *)statusItem;

@property (nonatomic, strong, readonly) NSStatusItem *statusItem;
@property (nonatomic, strong) NSImage *image;
@property (nonatomic, strong) NSImage *alternateImage;
@property (nonatomic, setter = setHighlighted:) BOOL isHighlighted;
@property (nonatomic, readonly) NSRect globalRect;
@property (nonatomic) SEL action;
@property (nonatomic, unsafe_unretained) id target;

@end
