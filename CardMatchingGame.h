//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Colin Smith on 1/10/15.
//  Copyright (c) 2015 Colin Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
-(instancetype)initWithCardCount: (NSUInteger)count usingDeck: (Deck *)deck;
-(void)chooseCardAtIndexTwoCards: (NSUInteger)index;
-(void)chooseCardAtIndexThreeCards: (NSUInteger)index;
-(Card *)cardAtIndex: (NSUInteger)index;

@property (nonatomic) BOOL threeCardGame;
@property (nonatomic) NSInteger numberOfCardsFlipped;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, strong) NSString *updatedScoreInformation;

@end
