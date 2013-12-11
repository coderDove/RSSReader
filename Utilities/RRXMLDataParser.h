//
//  RRXMLDataParser.h
//  RSSReader
//
//  Created by Alexey on 16.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRXMLDataParser : NSObject <NSXMLParserDelegate>{
    NSXMLParser *parser;
    NSMutableArray *parsedDataArray;
    NSMutableDictionary *currentElementDictionary;
    NSMutableString *currentString;
}

- (NSArray*)parseXml:(NSData*)xmlData;

@end
