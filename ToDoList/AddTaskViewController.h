//
//  AddTaskViewController.h
//  ToDoList
//
//  Created by Shimaa on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "InsertNewItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddTaskViewController : UIViewController

@property id <InsertNewItemProtocol> insertNewItem;

@end

NS_ASSUME_NONNULL_END
