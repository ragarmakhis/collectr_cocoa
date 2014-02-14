//
//  CLRCollectrController.m
//  collectr_cocoa
//
//  Created by Maksim Roshtshin on 12.02.14.
//  Copyright (c) 2014 ragarmakhis. All rights reserved.
//

#import "CLRCollectrController.h"

@implementation CLRCollectrController

@synthesize createTXTOnly;
//
//- (id) init {
//    if (self = [super init]) {
//        CLRCollectr * collectr = [[CLRCollectr alloc] init];
//    }
//    return self;
//}

- (IBAction)volumesSelectDialog:(id)sender {
    // Создать диалог
    NSOpenPanel *openDlg = [NSOpenPanel openPanel];
    
    // Свойства диалога
    [openDlg setCanChooseFiles:NO];
    [openDlg setCanChooseDirectories:YES];
    [openDlg setAllowsMultipleSelection:YES];
    [openDlg setDirectoryURL:[NSURL URLWithString:@"file:///Volumes"]];
//    [openDlg setResolvesAliases:YES];
    
    // Вывести диалог модально
    // Если запуск вернул нажатие кнопки OK - обработать выбранные файлы
    if ( [openDlg runModal] == NSFileHandlingPanelOKButton ) {
        
        // Список выбранных файлов
        collecrt.volumes = [openDlg URLs];
        
        // Показать выбранные файлы
        NSString * volumesString = [NSString string];
        for (id item in [collecrt volumes]) {
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
        collecrt.inputXML = [URLs firstObject];
        
        // Показать выбранные файлы
        [inputXMLTextField setStringValue:[[collecrt inputXML] path]];
    }
    
}

- (IBAction)typeXMLSelect:(id)sender {
    collecrt.typeXML = [[sender selectedItem] toolTip];
    
    [typeXMLTextField setStringValue:[collecrt typeXML]];
}

- (IBAction)typeSourceSelect:(id)sender {
    collecrt.typeSource = [[sender selectedItem] toolTip];
    
    [typeSourceTextField setStringValue:[collecrt typeSource]];
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
        collecrt.outputFolder = [URLs firstObject];
        
        // Показать выбранные файлы
        [outputFolderTextField setStringValue:[[collecrt outputFolder] path]];
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
        collecrt.outputTXT = [saveDlg URL];
        
        // Показать выбранные файлы
        [outputTXTTextField setStringValue:[[collecrt outputTXT] path]];
    }
}

- (BOOL)checkCreateTXTOnly {
    return [[NSNumber numberWithLong:[createTXTOnlyCheckBox state]] boolValue];
}

- (IBAction)createTXTOnlyCheckBox:(id)sender {
    collecrt.createTXTOnly = self.checkCreateTXTOnly;
    [createTXTOnlyTextField setStringValue:collecrt.createTXTOnly ? @"YES" : @"NO"];
}

- (IBAction)start:(id)sender {
    
}

@end
