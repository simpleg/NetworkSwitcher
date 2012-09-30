//
//  StatusItemView.m
//  NetworkSwitcher
//
//  Created by Jerome Heymonet on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StatusItemView.h"

@implementation StatusItemView

@synthesize statusItem;
@synthesize image;
@synthesize alternateImage;
@synthesize isHighlighted;
@synthesize action;
@synthesize target;

- (id)initWithStatusItem:(NSStatusItem *)aStatusItem {
    
    CGFloat itemWidth = [statusItem length];
    CGFloat itemHeight = [[NSStatusBar systemStatusBar] thickness];
    NSRect itemRect = NSMakeRect(0.0, 0.0, itemWidth, itemHeight);
    self = [super initWithFrame:itemRect];
    if (self) {
        statusItem = aStatusItem;
        statusItem.view = self;
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [statusItem drawStatusBarBackgroundInRect:dirtyRect withHighlight:isHighlighted];
    
    NSImage *icon = isHighlighted ? alternateImage : image;
    NSSize iconSize = [icon size];
    NSRect bounds = self.bounds;
    CGFloat iconX = roundf((NSWidth(bounds) - iconSize.width) / 2 );
    CGFloat iconY = roundf((NSHeight(bounds) - iconSize.height) / 2 );
    NSPoint iconPoint = NSMakePoint(iconX, iconY);
    [icon drawAtPoint:iconPoint fromRect:bounds operation:NSCompositeSourceOver fraction:1.0];
}

#pragma mark -
#pragma mark Mouse tracking

-(void) mouseDown:(NSEvent *)theEvent {
    [NSApp activateIgnoringOtherApps:YES];
    [NSApp sendAction:action to:target from:self];
}

#pragma mark -
#pragma mark Accessors

- (void)setHighlighted:(BOOL)newFlag {
    if (isHighlighted == newFlag) return;
    isHighlighted = newFlag;
    [self setNeedsDisplay:YES];
}

-(void)setImage:(NSImage *)newImage {
    if (image != newImage) {
        image = newImage;
        [self setNeedsDisplay:YES];
    }
}

-(void)setAlternateImage:(NSImage *)newImage {
    if (alternateImage != newImage) {
        alternateImage = newImage;
        if (isHighlighted) {
            [self setNeedsDisplay:YES];
        }
    }
}

-(NSRect)globalRect {
    NSRect frame = [self frame];
    frame.origin = [self.window convertBaseToScreen:frame.origin];
    return frame;
}

@end
