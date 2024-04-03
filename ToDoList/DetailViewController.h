//
//  DetailViewController.h
//  ToDoList
//
//  Created by Shimaa on 03/04/2024.
//

#import <UIKit/UIKit.h>
#import "NewTask.h"
#import "ToDoViewController.h"
#import "InsertNewItemProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property int index;
@property NewTask *taskObject;
@property id<InsertNewItemProtocol> update;

@end

NS_ASSUME_NONNULL_END
