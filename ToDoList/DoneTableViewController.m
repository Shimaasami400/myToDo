//
//  DoneTableViewController.m
//  ToDoList
//
//  Created by Shimaa on 03/04/2024.
//

#import "DoneTableViewController.h"
#import "NewTask.h"

@interface DoneTableViewController (){
    NSMutableArray *doneList;
    NSMutableArray <NewTask*> *doneFilteredList;
}

@end

@implementation DoneTableViewController
{
    NewTask *newTask;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    doneList = [NSMutableArray new];
    doneFilteredList = [NSMutableArray array];
    
    [self loadTasksFromUserDefaults];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [doneList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"donecell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NewTask *newTask = doneList[indexPath.row];
    cell.textLabel.text = newTask.name;
    
    return cell;
}

- (void)loadTasksFromUserDefaults {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *tasksData = [defaults objectForKey:@"ToDoListTasks"];
//
//    NSMutableArray *tasksArray = [NSKeyedUnarchiver unarchiveObjectWithData:tasksData];
//    for (NewTask *task in inProgressList) {
//            if ([task.status isEqualToString:@"Doing"]) {
//                        [doingFilteredList addObject:task];
//                    }
//            }
//
//        NSLog(@"Filtered List - doingFilteredList: %@", doingFilteredList);
//    //[toDoList addObjectsFromArray:tasksArray];
//    //inProgressList = tasksArray;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *tasksData = [defaults objectForKey:@"ToDoListTasks"];
        
        NSMutableArray *tasksArray = [NSKeyedUnarchiver unarchiveObjectWithData:tasksData];
        
        for (NewTask *task in tasksArray) {
            if ([task.status isEqualToString:@"2"]) {
                [doneList addObject:task];
            }
        }
        
        NSLog(@"In done List - doneList: %@", doneList);
        [self.tableView reloadData];
            
    
}

@end
