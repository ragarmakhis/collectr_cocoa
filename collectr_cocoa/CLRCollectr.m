//
//  CLRCollectr.m
//  collectr_cocoa
//
//  Created by Maksim Roshtshin on 13.02.14.
//  Copyright (c) 2014 ragarmakhis. All rights reserved.
//

#import "CLRCollectr.h"

@interface CLRCollectr () {
    BOOL isVideo;
    NSXMLParser *parser;
    NSMutableString *currentStringValue;
}

@end

@implementation CLRCollectr

- (id)init {
    if ((self = [super init])) {
        self.createTXTOnly = NO;
        self.typeXML = @"F";
        self.typeSource = @"R";
        self.inputXML = nil;
        isVideo = NO;
    }
    return self;
}

- (NSMutableSet *)mySet {
    if (!_mySet) {
        _mySet = [[NSMutableSet alloc] init];
    }
    return _mySet;
}

-(void)parseXML {
    self.mySet = nil;
//    NSData *xml = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"project" ofType:@"xml"]];
//    NSData *xml = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"408-13" ofType:@"xml"]];
    if (self.inputXML == nil) {
        NSLog(@"No input XML!!!");
        return;
    }
    NSData *xml = [[NSData alloc] initWithContentsOfURL:self.inputXML];

    
//    if (parser) [parser release]; // ARC forbids explicit message send of 'release'
    parser = [[NSXMLParser alloc] initWithData:xml];
    parser.delegate = self;
//    [parser setShouldResolveExternalEntities:YES]; //???????
    if ([parser parse]){
        NSLog(@"The XML is parsed.");
        NSLog(@"%@", self.mySet);
        
        
        NSError *error = NULL;
        NSMutableSet *tempSet = nil;
        
        NSRegularExpression *regexRED = [NSRegularExpression regularExpressionWithPattern:@"^[A-Z]\d{3}_[A-Z]\d{3}_\d{4}\w{2}" options:NSRegularExpressionCaseInsensitive error:&error];
        NSRegularExpression *regexARRI = [NSRegularExpression regularExpressionWithPattern:@"^[A-Z]\d{3}[A-Z]\d{3}_\d{6}_\w{4}" options:NSRegularExpressionCaseInsensitive error:&error];
        for (NSString *item in self.mySet) {
            NSTextCheckingResult *matchRED = [regexRED firstMatchInString:item options:0 range:NSMakeRange(0, [item length])];
            NSTextCheckingResult *matchARRI = [regexARRI firstMatchInString:item options:0 range:NSMakeRange(0, [item length])];
            NSString *newItem = [NSString string];
            if (matchRED){
                newItem = [item stringByAppendingString:@".RDC"];
            }
            if (matchARRI) {
                newItem = [item stringByAppendingString:@".mov"];
            }
            
            [tempSet addObject:newItem];
            [self.mySet removeObject:item];
        }
        
        [self.mySet unionSet:tempSet];
        
    } else{
        NSLog(@"Failed to parse the XML");
    }
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"SM_Project"]) {
        self.typeXML = @"D";
    } else if ([elementName isEqualToString:@"xmeml"]) {
        self.typeXML = @"F";
    }
    
    if ([self.typeXML isEqualToString:@"F"]) {
        if ( [elementName isEqualToString:@"video"]) {
            isVideo = YES;
            return;
        }
        
        if ( [elementName isEqualToString:@"file"] && isVideo) {
            [self.mySet addObject:[attributeDict objectForKey:@"id"]];
            //        isFile = YES;
            return;
        }
    }
    
    currentStringValue = nil;
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentStringValue) {
        currentStringValue = [[NSMutableString alloc] initWithCapacity:25];
    }
    [currentStringValue appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([self.typeXML isEqualToString:@"F"]) {
        if ( [elementName isEqualToString:@"video"]) {
            isVideo = NO;
            return;
        }
    }
    
    if ([self.typeXML isEqualToString:@"D"]) {
        if (!currentStringValue) {
            return;
        }
        
        if ( [elementName isEqualToString:@"MediaReelNumber"]) {
            [self.mySet addObject:[currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            return;
        }
    }
}

-(void)copingSources {
    if (self.volumes == nil) {
        self.volumes = [NSArray arrayWithObject:[NSURL URLWithString:NSHomeDirectory()]];
    }
    
    NSError *error = nil;
    
    for (NSURL *item in self.volumes) {
        NSArray *properties = [NSArray arrayWithObjects:NSURLLocalizedNameKey, NSURLCreationDateKey, NSURLLocalizedTypeDescriptionKey, nil];
        NSFileManager *localFileManager = [NSFileManager defaultManager];

        NSDirectoryEnumerator *directoryEnumerator = [localFileManager enumeratorAtURL:item includingPropertiesForKeys:properties options:(NSDirectoryEnumerationSkipsHiddenFiles) errorHandler:nil];
        
        for (NSURL *url in directoryEnumerator) {
            for (NSString *reelName in self.mySet) {
                if ([[url lastPathComponent] isEqualToString:reelName]) {
                    NSLog(@"%@ - BINGO", [url path]);
                    if (self.outputFolder) {
                        if (![localFileManager copyItemAtURL:url toURL:[self.outputFolder URLByAppendingPathComponent:url.lastPathComponent] error:&error]) {
                                NSLog(@"%@", [error localizedDescription]);
                            continue;
                        }
                        NSLog(@"from %@ to %@", [url path], [self.outputFolder path]);
                        NSLog(@"copied");
                    }
                }
            }
        }
    }
}

-(void)copyURL:(NSURL *)url{
    
}

@end
