//
//  CLRCollectrController.h
//  collectr_cocoa
//
//  Created by Maksim Roshtshin on 12.02.14.
//  Copyright (c) 2014 ragarmakhis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLRCollectr.h"
#import "CLRXMLElement.h"

@interface CLRCollectrController : NSObject <NSXMLParserDelegate> {
    IBOutlet NSTextField * volumesTextField;
    IBOutlet NSTextField * inputXMLTextField;
    IBOutlet NSTextField * typeXMLTextField;
    IBOutlet NSTextField * typeSourceTextField;
    IBOutlet NSTextField * outputFolderTextField;
    IBOutlet NSTextField * outputTXTTextField;
    IBOutlet NSTextView * outputLogTextView;
    IBOutlet NSTextField * createTXTOnlyTextField;
    IBOutlet NSButton * createTXTOnlyCheckBox;
}

@property (strong, nonatomic) CLRCollectr * collecrt;

@property (nonatomic, strong) NSXMLParser *xmlParser;
@property (nonatomic, strong) CLRXMLElement *rootElement;
@property (nonatomic, strong) CLRXMLElement *currentElementPointer;


//@property (nonatomic, copy) NSString* name;
//@property (nonatomic, strong) NSMutableString* text;
//@property (nonatomic, weak) CLRCollectrController* parent;
//@property (nonatomic, strong) CLRCollectrController* child;
//- (void)start: (NSString*) elementName parent: (id) parent;
//- (void)makeChild:(Class)class elementName:(NSString*)elementName parser:(NSXMLParser*)parser;
//- (void)finishedChild:(NSString*)s;

- (IBAction)volumesSelectDialog:(id)sender;
- (IBAction)inputXMLDialog:(id)sender;
- (IBAction)typeXMLSelect:(id)sender;
- (IBAction)typeSourceSelect:(id)sender;
- (IBAction)outputFolderDialog:(id)sender;
- (IBAction)outputTXTDialog:(id)sender;
- (IBAction)createTXTOnlyCheckBox:(id)sender;
- (IBAction)start:(id)sender;

@end
