//
//  InsertNewItemProtocol.h
//  ToDoList
//
//  Created by Shimaa on 02/04/2024.
//

#import <Foundation/Foundation.h>
#import "NewTask.h"
NS_ASSUME_NONNULL_BEGIN

@protocol InsertNewItemProtocol <NSObject>

- (void)insertTask:(NewTask *)newTaskObject;

@end

NS_ASSUME_NONNULL_END
