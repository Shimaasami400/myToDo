//
//  ToDoViewController.h
//  ToDoList
//
//  Created by Shimaa on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "InsertNewItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoViewController : UIViewController <InsertNewItemProtocol,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

//@property (weak, nonatomic) IBOutlet UITableView *toDoTable;




@end

NS_ASSUME_NONNULL_END
