//
//  PlayingCard.m
//  Matchismo
//
//  Created by Colin Smith on 1/9/15.
//  Copyright (c) 2015 Colin Smith. All rights reserved.
//

#import "PlayingCard.h"
#import "ScoreBoard.h"

@implementation PlayingCard

NSString *matchBySuit = @" match by suit. ";
NSString *matchByRank = @" match by rank. ";
NSString *doNotMatch = @" don't match. ";
NSString *tempContents;

- (NSString *) setUpdatedInformationStringForCardContentsOne:(NSString *)cardContentsOne cardContentsTwo:(NSString *)cardContentsTwo suitOrRank: (NSString *)suitOrRank {
    
    return [[cardContentsOne stringByAppendingString:cardContentsTwo] stringByAppendingString:suitOrRank];
}

- (NSString *) setUpdatedInformationStringForCardContentsOne:(NSString *)cardContentsOne cardContentsTwo:(NSString *)cardContentsTwo cardContentsThree:(NSString *)cardContentsThree suitOrRank: (NSString *)suitOrRank {
    
    return [[[cardContentsOne stringByAppendingString:cardContentsTwo] stringByAppendingString:cardContentsThree] stringByAppendingString:suitOrRank];
}

- (int) match:(NSArray *)otherCards
{
    int score = 0;
    self.updatedScoreInformation = @"";
    
    if ([otherCards count] == 1)
    {
        PlayingCard *otherCard = [otherCards firstObject];
        if ([self.suit isEqualToString:otherCard.suit])
        {
            score = 1;
        }
        else if (self.rank == otherCard.rank)
        {
            score = 4;
        }
    }
    //Three Card Match Section
    else if([otherCards count] > 1)
    {
        PlayingCard *firstCard = [otherCards firstObject];
        PlayingCard *secondCard = [otherCards objectAtIndex:1];
        PlayingCard *thirdCard = [otherCards objectAtIndex:2];
        
        if ([thirdCard.suit isEqualToString:firstCard.suit])
        {
            score += 1;
            thirdCard.matched = YES;
            thirdCard.chosen = NO;
            firstCard.matched = YES;
            firstCard.chosen = NO;
            
            [self.updatedScoreInformation stringByAppendingString:
             [self setUpdatedInformationStringForCardContentsOne:firstCard.contents cardContentsTwo:thirdCard.contents suitOrRank:matchBySuit]];
       
        
        } else if ([thirdCard.suit isEqualToString:secondCard.suit]) {
            score += 1;
            thirdCard.matched = YES;
            thirdCard.chosen = NO;
            secondCard.matched = YES;
            secondCard.chosen = NO;
            
            [self.updatedScoreInformation stringByAppendingString:
             [self setUpdatedInformationStringForCardContentsOne:secondCard.contents cardContentsTwo:thirdCard.contents suitOrRank:matchBySuit]];
            
        } else if ([firstCard.suit isEqualToString:secondCard.suit]) {
            score += 1;
            firstCard.matched = YES;
            firstCard.chosen = NO;
            secondCard.matched = YES;
            secondCard.chosen = NO;
            
            [self.updatedScoreInformation stringByAppendingString:
             [self setUpdatedInformationStringForCardContentsOne:firstCard.contents cardContentsTwo:secondCard.contents suitOrRank:matchBySuit]];
            
        } if (thirdCard.rank == firstCard.rank) {
            score += 2;
            thirdCard.matched = YES;
            thirdCard.chosen = NO;
            firstCard.matched = YES;
            firstCard.chosen = NO;
            
            [self.updatedScoreInformation stringByAppendingString:
             [self setUpdatedInformationStringForCardContentsOne:firstCard.contents cardContentsTwo:thirdCard.contents suitOrRank:matchByRank]];
            
        } else if (thirdCard.rank == secondCard.rank) {
            score += 2;
            thirdCard.matched = YES;
            thirdCard.chosen = NO;
            secondCard.matched = YES;
            secondCard.chosen = NO;
            
            [self.updatedScoreInformation stringByAppendingString:
             [self setUpdatedInformationStringForCardContentsOne:secondCard.contents cardContentsTwo:thirdCard.contents suitOrRank:matchByRank]];
            
        } else if (firstCard.rank == secondCard.rank) {
            score += 2;
            firstCard.matched = YES;
            firstCard.chosen = NO;
            secondCard.matched = YES;
            secondCard.chosen = NO;
            
            [self.updatedScoreInformation stringByAppendingString:
             [self setUpdatedInformationStringForCardContentsOne:firstCard.contents cardContentsTwo:secondCard.contents suitOrRank:matchBySuit]];
            
        } if ([thirdCard.suit isEqualToString:firstCard.suit] && [thirdCard.suit isEqualToString:secondCard.suit] && [firstCard.suit isEqualToString:secondCard.suit]) {
            score = 4;
            thirdCard.matched = YES;
            thirdCard.chosen = NO;
            firstCard.matched = YES;
            firstCard.chosen = NO;
            secondCard.matched = YES;
            secondCard.chosen = NO;
            
            self.updatedScoreInformation = [self setUpdatedInformationStringForCardContentsOne:firstCard.contents cardContentsTwo:secondCard.contents cardContentsThree:thirdCard.contents suitOrRank:matchBySuit];
            
        } if (thirdCard.rank == firstCard.rank && thirdCard.rank == secondCard.rank && firstCard.rank == secondCard.rank) {
            score = 8;
            thirdCard.matched = YES;
            thirdCard.chosen = NO;
            firstCard.matched = YES;
            firstCard.chosen = NO;
            secondCard.matched = YES;
            secondCard.chosen = NO;
            
            self.updatedScoreInformation = [self setUpdatedInformationStringForCardContentsOne:firstCard.contents cardContentsTwo:secondCard.contents cardContentsThree:thirdCard.contents suitOrRank:matchByRank];
        }
        
    }
    
    
    
    return score;
}

-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; //because we modified the getter AND setter

+ (NSArray *)validSuits
{
    return @[@"♥", @"♦", @"♠", @"♣"];
}

- (void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
    
}

-(NSString *) suit
{
    //nil suit will return ?
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {return [[self rankStrings] count] - 1; }

- (void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

@end
