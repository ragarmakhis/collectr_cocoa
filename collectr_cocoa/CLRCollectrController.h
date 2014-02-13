//
//  CLRCollectrController.h
//  collectr_cocoa
//
//  Created by Maksim Roshtshin on 12.02.14.
//  Copyright (c) 2014 ragarmakhis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLRCollectr.h"

@interface CLRCollectrController : NSObject {
    IBOutlet NSTextField * volumesTextField;
    IBOutlet NSTextField * inputXMLTextField;
    IBOutlet NSTextField * typeXMLTextField;
    IBOutlet NSTextField * typeSourceTextField;
    IBOutlet NSTextField * outputFolderTextField;
    IBOutlet NSTextField * outputTXTTextField;
    IBOutlet NSTextView * outlutLogTextView;
    IBOutlet NSTextField * createTXTOnlyTextField;
    IBOutlet NSButton * createTXTOnlyCheckBox;
    
    CLRCollectr * collecrt;
    BOOL createTXTOnly;
}

@property BOOL creareTXTOnly;

- (IBAction)volumesSelectDialog:(id)sender;
- (IBAction)inputXMLDialog:(id)sender;
- (IBAction)typeXMLSelect:(id)sender;
- (IBAction)typeSourceSelect:(id)sender;
- (IBAction)outputFolderDialog:(id)sender;
- (IBAction)outputTXTDialog:(id)sender;
- (IBAction)createTXTOnlyCheckBox:(id)sender;
- (IBAction)start:(id)sender;

- (BOOL)checkCreateTXTOnly;

@end