//
//  RRXMLDataParser.m
//  RSSReader
//
//  Created by Alexey on 16.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import "RRXMLDataParser.h"

@implementation RRXMLDataParser

- (NSArray*)parseXml:(NSData *)xmlData {
    parsedDataArray = [[NSMutableArray alloc] init];
    parser = [[NSXMLParser alloc] initWithData:xmlData];
    parser.delegate = self;
    [parser parse];
    return [parsedDataArray autorelease];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    currentElementDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    NSString *element = [self preparedString:elementName];
    [self performCustomSelector:[NSString stringWithFormat:@"handleElement_%@:", element] withObject:attributeDict];
}

- (NSString *)preparedString:(NSString*)inputString {
    NSMutableString *element = [NSMutableString stringWithString:inputString];
    [element replaceOccurrencesOfString:@":" withString:@"_" options:NSLiteralSearch range: NSMakeRange(0, element.length)];
    return element;
}

- (void)performCustomSelector:(NSString*)selectorName withObject:(NSDictionary*)object{
    SEL selector = NSSelectorFromString(selectorName);
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:object];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (currentString) {
        [currentString appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSString *element = [self preparedString:elementName];
    [self performCustomSelector:[NSString stringWithFormat:@"handleCloseElement_%@:", element] withObject:nil];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"Parse Error: %@", parseError.description);
}

#pragma mark -
#pragma mark Element handlers
-(void) handleElement_item: (NSDictionary*) attributes{
    currentElementDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
}

-(void) handleCloseElement_item: (NSDictionary*) attributes{
    [parsedDataArray addObject:currentElementDictionary];
    [currentElementDictionary release];
}

-(void) handleElement_title: (NSDictionary*) attributes{
    [self initCurrentString];
}

-(void) handleCloseElement_title: (NSDictionary*) attributes{
    [currentElementDictionary setObject:currentString forKey:@"title"];
    [self clearCurrentString];
}

-(void) handleElement_link: (NSDictionary*) attributes{
    [self initCurrentString];
}

-(void) handleCloseElement_link: (NSDictionary*) attributes{
    [currentElementDictionary setObject:currentString forKey:@"link"];
    [self clearCurrentString];
}

-(void) handleElement_pubDate: (NSDictionary*) attributes{
    [self initCurrentString];
}

-(void) handleCloseElement_pubDate: (NSDictionary*) attributes{
    [currentElementDictionary setObject:currentString forKey:@"pubDate"];
    [self clearCurrentString];
}

-(void) handleElement_media_thumbnail: (NSDictionary*) attributes{
    [currentElementDictionary setObject:[attributes valueForKey:@"url"] forKey:@"image"];
}

-  (void)initCurrentString {
    currentString = [[NSMutableString alloc] init];
}

-  (void)clearCurrentString {
    currentString = nil;
    [currentString release];
}

@end
