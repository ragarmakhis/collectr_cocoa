//
//  CLRXMLElement.h
//  collectr_cocoa
//
//  Created by Maksim Roshtshin on 22.02.14.
//  Copyright (c) 2014 ragarmakhis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLRXMLElement : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSDictionary *attributes;
@property (nonatomic, strong) NSMutableArray *subElements;
@property (nonatomic, weak) CLRXMLElement *parent;

@end
