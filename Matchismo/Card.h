//
//  Card.h
//  Matchismo
//
//  Created by Colin Smith on 1/9/15.
//  Copyright (c) 2015 Colin Smith. All rights reserved.
//

@import Foundation;

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;
@property (strong, nonatomic) NSString *updatedScoreInformation;



- (int)match: (NSArray *)otherCards;



@end
