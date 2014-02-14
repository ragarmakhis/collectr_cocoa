//
//  CLRCollectr.h
//  collectr_cocoa
//
//  Created by Maksim Roshtshin on 13.02.14.
//  Copyright (c) 2014 ragarmakhis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLRCollectr : NSObject {
//    NSArray * volumes; //Array of URLs
//    NSURL * inputXML;
//    NSString * typeXML;
//    NSString * typeSource;
//    NSURL * outputFolder;
//    NSURL * outputTXT;
//    BOOL createTXTOnly;
}

@property (strong) NSArray *volumes; //Array of URLs
@property (strong) NSURL *inputXML;
@property (strong) NSString *typeXML;
@property (strong) NSString *typeSource;
@property (strong) NSURL *outputFolder;
@property (strong) NSURL *outputTXT;
@property BOOL createTXTOnly;

@end
