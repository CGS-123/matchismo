//
//  PlayingCard.h
//  Matchismo
//
//  Created by Colin Smith on 1/9/15.
//  Copyright (c) 2015 Colin Smith. All rights reserved.
//



#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;



+ (NSArray *)validSuits;
+ (NSUInteger) maxRank;


@end