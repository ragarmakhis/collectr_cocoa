//
//  CLRCollectr.m
//  collectr_cocoa
//
//  Created by Maksim Roshtshin on 13.02.14.
//  Copyright (c) 2014 ragarmakhis. All rights reserved.
//

#import "CLRCollectr.h"

@implementation CLRCollectr
//
//@synthesize volumes, inputXML, typeXML, typeSource, outputFolder, outputTXT;
//@synthesize createTXTOnly;

- (id)init {
    if ((self = [super init])) {
        self.createTXTOnly = NO;
        self.typeXML = @"F";
        self.typeSource = @"R";
        self.inputXML = nil;
    }
    return self;
}

@end
