//
//  NewTask.h
//  ToDoList
//
//  Created by Shimaa on 02/04/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewTask : NSObject <NSCoding>

@property NSString *name ;
@property NSString *desc;
@property NSString *priority;
@property NSString *status;
@property NSString *date;

@end

NS_ASSUME_NONNULL_END
