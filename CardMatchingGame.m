//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Colin Smith on 1/10/15.
//  Copyright (c) 2015 Colin Smith. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *cardsUsedForThreeCardScoreMatching;


@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(instancetype)initWithCardCount: (NSUInteger)count usingDeck: (Deck *)deck
{
    self = [super init];
    
    if(self)
    {
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if(card)
            {
                [self.cards addObject:card];
            }
            else
            {
                self = nil;
                break;
            }
            
        }
        
        self.cardsUsedForThreeCardScoreMatching = [[NSMutableArray alloc] init];
    }
    
    
    
    return self;
}


static const int TWO_CARD_MISMATCH_PENALTY = 2;
static const int TWO_CARD_MATCH_BONUS = 4;
static const int TWO_CARD_COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndexTwoCards:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched)
    {
        if (card.isChosen)
        {
            card.chosen = NO;
        }
        else
        {
            //match against another card
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isChosen && !otherCard.isMatched)
                {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore)
                    {
                        self.score += matchScore * TWO_CARD_MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    }
                    else
                    {
                        self.score -= TWO_CARD_MISMATCH_PENALTY;
                        
                        otherCard.chosen = NO;
                        
                    }
                    break;
                }
            }
            self.score -= TWO_CARD_COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

static const int THREE_CARD_MISMATCH_PENALTY = 3;
static const int THREE_CARD_MATCH_BONUS = 4;
static const int THREE_CARD_COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndexThreeCards:(NSUInteger)index {
    
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched) {
        
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            if (self.threeCardGame && self.numberOfCardsFlipped == 4) {
                
                card.chosen = NO;
                [self.cardsUsedForThreeCardScoreMatching removeAllObjects];
                for (Card *checkForChosen in self.cards) {
                    if(checkForChosen.chosen == YES) {
                        [self.cardsUsedForThreeCardScoreMatching addObject:checkForChosen];
                    }
                }
                
                int matchScore = [card match:self.cardsUsedForThreeCardScoreMatching];
                if (matchScore)
                {
                    self.score += matchScore * THREE_CARD_MATCH_BONUS;
                    
                    //refactor
                    for (Card *flipToCardBack in self.cards) {
                        if (flipToCardBack.chosen && !flipToCardBack.matched) {
                            flipToCardBack.chosen = NO;
                        }
                    }
                    
                    self.updatedScoreInformation = card.updatedScoreInformation;
                    self.numberOfCardsFlipped = 0;
                }
                else
                {
                    self.score -= THREE_CARD_MISMATCH_PENALTY;
                    
                    //refactor
                    for (Card *flipToCardBack in self.cards) {
                        if (flipToCardBack.chosen && !flipToCardBack.matched) {
                            flipToCardBack.chosen = NO;
                        }
                    }
                    
                    self.updatedScoreInformation = @"No matches, tough luck. -3 points";
                    self.numberOfCardsFlipped = 0;
                }
            } else {
                self.score -= THREE_CARD_COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
