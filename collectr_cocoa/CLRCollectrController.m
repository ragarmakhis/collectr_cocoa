//
//  CLRCollectrController.m
//  collectr_cocoa
//
//  Created by Maksim Roshtshin on 12.02.14.
//  Copyright (c) 2014 ragarmakhis. All rights reserved.
//

#import "CLRCollectrController.h"

@implementation CLRCollectrController

@synthesize collecrt=_collecrt;

	- (void)setCollecrt:(CLRCollectr *)collecrt {
    _collecrt = collecrt;
}

- (CLRCollectr *)collecrt {
    if (!_collecrt) _collecrt = [[CLRCollectr alloc] init];
    return _collecrt;
}

- (NSMutableSet *)mySet {
    if (!_mySet) {
        _mySet = [[NSMutableSet alloc] init];
    }
    return _mySet;
}

- (IBAction)volumesSelectDialog:(id)sender {
    // Создать диалог
    NSOpenPanel *openDlg = [NSOpenPanel openPanel];
    
    // Свойства диалога
    [openDlg setCanChooseFiles:NO];
    [openDlg setCanChooseDirectories:YES];
    [openDlg setAllowsMultipleSelection:YES];
    [openDlg setDirectoryURL:[NSURL URLWithString:@"file:///Volumes"]];
    
    // Вывести диалог модально
    // Если запуск вернул нажатие кнопки OK - обработать выбранные файлы
    if ( [openDlg runModal] == NSFileHandlingPanelOKButton ) {
        
        // Список выбранных файлов
        self.collecrt.volumes = [openDlg URLs];
        
        // Показать выбранные файлы
        NSString * volumesString = [NSString string];
        for (id item in [self.collecrt volumes]) {
            volumesString = [volumesString stringByAppendingString:[item path]];
            volumesString = [volumesString stringByAppendingString:@"; "];
        }
        volumesString = [volumesString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"; "]];
        [volumesTextField setStringValue:volumesString];
    }
}

- (IBAction)inputXMLDialog:(id)sender {
    // Создать диалог
    NSOpenPanel *openDlg = [NSOpenPanel openPanel];
    
    // Свойства диалога
    [openDlg setCanChooseFiles:YES];
    [openDlg setCanChooseDirectories:NO];
    [openDlg setAllowsMultipleSelection:NO];
    [openDlg setAllowedFileTypes:[NSArray arrayWithObject:@"xml"]];
    
    
    // Вывести диалог модально
    // Если запуск вернул нажатие кнопки OK - обработать выбранные файлы
    if ( [openDlg runModal] == NSFileHandlingPanelOKButton ) {
        
        // Список выбранных файлов
        NSArray *URLs = [openDlg URLs];
        self.collecrt.inputXML = [URLs firstObject];
        
        // Показать выбранные файлы
        [inputXMLTextField setStringValue:[[self.collecrt inputXML] path]];
    }
    
}

- (IBAction)typeXMLSelect:(id)sender {
    self.collecrt.typeXML = [[sender selectedItem] toolTip];
    
    [typeXMLTextField setStringValue:[self.collecrt typeXML]];
}

- (IBAction)typeSourceSelect:(id)sender {
    self.collecrt.typeSource = [[sender selectedItem] toolTip];
    
    [typeSourceTextField setStringValue:[self.collecrt typeSource]];
}

- (IBAction)outputFolderDialog:(id)sender {
    // Создать диалог
    NSOpenPanel *openDlg = [NSOpenPanel openPanel];
    
    // Свойства диалога
    [openDlg setCanChooseFiles:NO];
    [openDlg setCanChooseDirectories:YES];
    [openDlg setAllowsMultipleSelection:NO];
    
    // Вывести диалог модально
    // Если запуск вернул нажатие кнопки OK - обработать выбранные файлы
    if ( [openDlg runModal] == NSFileHandlingPanelOKButton ) {
        
        // Список выбранных файлов
        NSArray *URLs = [openDlg URLs];
        self.collecrt.outputFolder = [URLs firstObject];
        
        // Показать выбранные файлы
        [outputFolderTextField setStringValue:[[self.collecrt outputFolder] path]];
    }
}

- (IBAction)outputTXTDialog:(id)sender {
    // Создать диалог
    NSSavePanel *saveDlg = [NSSavePanel savePanel];
    
    // Свойства диалога
    [saveDlg setAllowedFileTypes:[NSArray arrayWithObject:@"txt"]];
    
    // Вывести диалог модально
    // Если запуск вернул нажатие кнопки OK - обработать выбранные файлы
    if ( [saveDlg runModal] == NSFileHandlingPanelOKButton ) {
        
        // Список выбранных файлов
        self.collecrt.outputTXT = [saveDlg URL];
        
        // Показать выбранные файлы
        [outputTXTTextField setStringValue:[[self.collecrt outputTXT] path]];
    }
}

- (IBAction)createTXTOnlyCheckBox:(id)sender {
    self.collecrt.createTXTOnly = [[NSNumber numberWithLong:[createTXTOnlyCheckBox state]] boolValue];
    [createTXTOnlyTextField setStringValue:self.collecrt.createTXTOnly ? @"YES" : @"NO"];
}

- (IBAction)start:(id)sender {
    
//    if (self.collecrt.inputXML == nil) {
//        [outputLogTextView insertText:@"No input XML!!!\n\n"];
//        return;
//    }
    
    NSString *xmlFilePath = [[NSBundle mainBundle] pathForResource:@"408-13" ofType:@"xml"];
//    NSString *xmlFilePath = [[NSBundle mainBundle] pathForResource:@"MyXML" ofType:@"xml"];
    NSData *xml = [[NSData alloc] initWithContentsOfFile:xmlFilePath];
//    NSData *xml = [[NSData alloc] initWithContentsOfURL:self.collecrt.inputXML];
    self.xmlParser = [[NSXMLParser alloc] initWithData:xml];
    self.xmlParser.delegate = self;
    if ([self.xmlParser parse]){
//        NSMutableSet *set = [NSMutableSet set];
        NSLog(@"The XML is parsed.");
        if ([self.currentElementPointer.name isEqualToString:@"file"]) {
            NSLog(@"%@", self.currentElementPointer.attributes);
        }
        NSLog(@"%@", self.mySet);
        NSLog(@"%@", self.myArray);
        
        /* self.rootElement is now the root element in the XML */
//        CLRXMLElement *element = self.rootElement.subElements[1];
//        NSLog(@"%@", self.rootElement.subElements);
//        NSLog(@"%@", [[element.subElements firstObject] text]);
    } else{
        NSLog(@"Failed to parse the XML");
    }
    
    
//    if (!self.collecrt.outputTXT) {
//        self.collecrt.outputTXT = [NSURL fileURLWithPath:[NSString stringWithFormat:@"/tmp/%@.txt", [self.collecrt.inputXML lastPathComponent]]];
//    }
//    [outputLogTextView insertText:[self.collecrt.outputTXT path]];
//    
//    if (!self.collecrt.outputFolder) {
//        self.collecrt.outputFolder = [self.collecrt.inputXML URLByDeletingLastPathComponent];
//    }
//    
//    NSString *xmlPath = @"";
//    if ([self.collecrt.typeXML isEqualToString:@"F"]) {
//        xmlPath = @".//sequence/media/video/track/clipitem/file/name";
//    } else {
//        xmlPath = @".//VideoTrackVec/Element/Sm2TiTrack/Items/Element/Sm2TiVideoClip/MediaReelNumber";
//    }
    
//    NSString *xmlSearch = @"";
//    if ([self.collecrt.typeSource isEqualToString:@"R"]) {
//        xmlSearch = @"^[A-Z]\d{3}_[A-Z]\d{3}_\d{4}\w{2}";
//    } else {
//        xmlSearch = @"^[A-Z]\d{3}[A-Z]\d{3}_\d{4}\w{2}";
//    }
    
    
}

-(void)parserDidStartDocument:(NSXMLParser *)parser {
    self.rootElement = nil;
    self.currentElementPointer = nil;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
//    BOOL video = YES;
    
    if (self.rootElement == nil) {
        /* We don't have a root element. Create it and point to it */
        self.rootElement = [[CLRXMLElement alloc] init];
        self.currentElementPointer = self.rootElement;
    } else {
        /* Already have root. Create new element and add it as one of
         the subelements of the current element */
        CLRXMLElement *newElement = [[CLRXMLElement alloc] init];
        newElement.parent = self.currentElementPointer;
        [self.currentElementPointer.subElements addObject:newElement];
        self.currentElementPointer = newElement;
    }
    self.currentElementPointer.name = elementName;
    self.currentElementPointer.attributes = attributeDict;
    
//    if ([elementName isEqualToString:@"video"]) {
//        video = YES;
//    }
    if ([self.currentElementPointer.name isEqualToString:@"name"] && [self.currentElementPointer.parent.name isEqualToString:@"file"]) {
        [self.mySet addObject:[self.currentElementPointer.parent.attributes objectForKey:@"id"]];
//        NSLog(@"%@", self.currentElementPointer.text);
    }
    
//    if ([elementName isEqualToString:@"file"]) {
//        //        if ([attributeDict isEqualToString:@"id"]) {
//        //            NSLog(@"%@", attributeDict);
//        //        }
//        [self.mySet addObject:[attributeDict objectForKey:@"id"]];
//        [self.myArray addObject:[attributeDict objectForKey:@"id"]];
//        NSLog(@"%@", [attributeDict objectForKey:@"id"]);
////        video = NO;
//    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([self.currentElementPointer.text length] > 0) {
        self.currentElementPointer.text = [self.currentElementPointer.text stringByAppendingString:string];
    } else {
        self.currentElementPointer.text = string;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    self.currentElementPointer = self.currentElementPointer.parent;
}

-(void)parserDidEndDocument:(NSXMLParser *)parser {
    self.currentElementPointer = nil;
}

@end
