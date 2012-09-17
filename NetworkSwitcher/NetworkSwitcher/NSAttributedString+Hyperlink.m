//
//  NSObject+NSAttributedString_Hyperlink.m
//  NetworkSwitcher
//
//  Created by Jerome on 17/09/12.
//  Copyright (c) 2012 simplegCorp. All rights reserved.
//

#import "NSAttributedString+Hyperlink.h"


@implementation NSAttributedString (Hyperlink)
+(id)hyperlinkFromString:(NSString*)inString withURL:(NSURL*)aURL {
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString: inString];
    NSRange range = NSMakeRange(0, [attrString length]);
 	
    [attrString beginEditing];
    [attrString addAttribute:NSLinkAttributeName value:[aURL absoluteString] range:range];
 	
    // make the text appear in blue
    [attrString addAttribute:NSForegroundColorAttributeName value:[NSColor blueColor] range:range];

    
 	[attrString addAttribute:NSFontAttributeName value:[NSFont systemFontOfSize:13] range:range];
    
    // next make the text appear with an underline
    [attrString addAttribute:
 	 NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSSingleUnderlineStyle] range:range];
 	
    [attrString endEditing];
 	
    return attrString;
}
@end