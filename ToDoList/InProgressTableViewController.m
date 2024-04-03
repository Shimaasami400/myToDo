//
//  InProgressTableViewController.m
//  ToDoList
//
//  Created by Shimaa on 03/04/2024.
//

#import "InProgressTableViewController.h"
#import "NewTask.h"

@interface InProgressTableViewController (){
    NSMutableArray *inProgressList;
    NSMutableArray <NewTask*> *doingFilteredList;
}

@end

@implementation InProgressTableViewController
{
    NewTask *newTask;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    inProgressList = [NSMutableArray new];
    doingFilteredList = [NSMutableArray array];
    
    [self loadTasksFromUserDefaults];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [inProgressList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inprogresscell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NewTask *newTask = inProgressList[indexPath.row];
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
            if ([task.status isEqualToString:@"1"]) {
                [inProgressList addObject:task];
            }
        }
        
        NSLog(@"In Progress List - inProgressList: %@", inProgressList);
        [self.tableView reloadData]; 
            
    
}


//- (void)filterTasksByStatus {
//    for (NewTask *task in inProgressList) {
//            if ([task.status isEqualToString:@"Doing"]) {
//                        [doingFilteredList addObject:task];
//                    }
//            }
//       
//        NSLog(@"Filtered List - doingFilteredList: %@", doingFilteredList);
//        //[self.inProgressList reloadData];
//}



@end
