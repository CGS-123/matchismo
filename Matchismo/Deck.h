//
//  Deck.h
//  Matchismo
//
//  Created by Colin Smith on 1/9/15.
//  Copyright (c) 2015 Colin Smith. All rights reserved.
//

@import Foundation;
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;


@end

