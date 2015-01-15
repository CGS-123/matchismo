//
//  Card.m
//  Matchismo
//
//  Created by Colin Smith on 1/9/15.
//  Copyright (c) 2015 Colin Smith. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

@synthesize contents = _contents;
@synthesize matched = _matched;
@synthesize chosen = _chosen;

- (NSString *) contents
{
    return _contents;
}

-(void)setContents:(NSString *)contents
{
    _contents = contents;
}

- (BOOL) isMatched
{
    return _matched;
}

-(void) setMatched: (BOOL) matched
{
    _matched = matched;
}

- (BOOL) isChosen
{
    return _chosen;
}

-(void) isChosen : (BOOL) chosen
{
    _chosen = chosen;
}

- (int)match:(NSArray *) otherCards
{
    int score = 0;
    
    for (Card *card in otherCards)
    {
        if ([card.contents isEqualToString: self.contents])
        {
            score = 1;
        }
    }
    
    return score;
}





@end