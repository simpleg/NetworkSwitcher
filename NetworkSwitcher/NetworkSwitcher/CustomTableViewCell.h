//
//  CustomTableViewCell.h
//  NetworkSwitcher
//
//  Created by Jerome Heymonet on 25/06/12.
//  Copyright (c) 2012 simplegCorp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CustomTableViewCell : NSTableCellView {
@private
    IBOutlet NSTextField *displayNameTextField;
    IBOutlet NSImageView *imageViewField;
    IBOutlet NSTextField *TextField;
    IBOutlet NSButton *callButton;
    
    
}

@end
