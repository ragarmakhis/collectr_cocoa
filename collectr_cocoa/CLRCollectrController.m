//
//  CLRCollectrController.m
//  collectr_cocoa
//
//  Created by Maksim Roshtshin on 12.02.14.
//  Copyright (c) 2014 ragarmakhis. All rights reserved.
//

#import "CLRCollectrController.h"
#import "ZipFile.h"
#import "FileInZipInfo.h"

@implementation CLRCollectrController

- (CLRCollectr *)collecrt {
    if (!_collecrt) _collecrt = [[CLRCollectr alloc] init];
    return _collecrt;
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
    [openDlg setAllowedFileTypes:[NSArray arrayWithObjects:@"xml", nil]];
    
    
    // Вывести диалог модально
    // Если запуск вернул нажатие кнопки OK - обработать выбранные файлы
    if ( [openDlg runModal] == NSFileHandlingPanelOKButton ) {
        
        // Список выбранных файлов
        NSArray *URLs = [openDlg URLs];
        if ([[[[URLs firstObject] lastPathComponent] pathExtension] isEqualToString:@"drp"]) {
            ZipFile *unzipFile= [[ZipFile alloc] initWithFileName:@"test.zip" mode:ZipFileModeUnzip];
            
            NSArray *infos= [unzipFile listFileInZipInfos];
            for (FileInZipInfo *info in infos) {
                NSLog(@"- %@ %@ %lu (%d)", info.name, info.date, (unsigned long)info.size,
                      info.level);
                
                // Locate the file in the zip
                [unzipFile locateFileInZip:info.name];
                
                // Expand the file in memory
                ZipReadStream *read= [unzipFile readCurrentFileInZip];
                NSMutableData *data= [[NSMutableData alloc] initWithLength:256];
                int bytesRead= [read readDataWithBuffer:data];
                [read finishedReading];
            }
        }
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
    [self.collecrt parseXML];
    
    for (NSString *item in self.collecrt.mySet) {
        [outputLogTextView insertText:[item stringByAppendingString:@"\n"]];
    }
    
    [self.collecrt copingSources];
}

@end
