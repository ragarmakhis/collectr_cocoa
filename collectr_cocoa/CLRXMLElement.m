//
//  CLRXMLElement.m
//  collectr_cocoa
//
//  Created by Maksim Roshtshin on 22.02.14.
//  Copyright (c) 2014 ragarmakhis. All rights reserved.
//

#import "CLRXMLElement.h"

@implementation CLRXMLElement

-(NSMutableArray *)subElements {
    if (_subElements == nil) {
        _subElements = [[NSMutableArray alloc] init];
    }
    return _subElements;
}

@end
