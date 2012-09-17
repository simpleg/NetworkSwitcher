//
//  NSObject+NSAttributedString_Hyperlink.h
//  NetworkSwitcher
//
//  Created by Jerome on 17/09/12.
//  Copyright (c) 2012 simplegCorp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSAttributedString (Hyperlink)
+(id)hyperlinkFromString:(NSString*)inString withURL:(NSURL*)aURL;
@end
