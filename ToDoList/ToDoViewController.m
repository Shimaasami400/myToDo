//
//  ToDoViewController.m
//  ToDoList
//
//  Created by Shimaa on 02/04/2024.
//

#import "ToDoViewController.h"
#import "AddTaskViewController.h"
#import "NewTask.h"
#import "DetailViewController.h"

@interface ToDoViewController (){

    NSMutableArray *toDoList;
    AddTaskViewController *addTaskViewController;
    NSMutableArray <NewTask*> *highFilteredList;
    NSMutableArray <NewTask*> *midFilteredList;
    NSMutableArray <NewTask*> *lowFilteredList;

}
@property (weak, nonatomic) IBOutlet UITableView *toDoTable;
@property NSMutableArray <NewTask*> *taskes;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;
@property (weak, nonatomic) IBOutlet UIToolbar *searchBar;

@end

@implementation ToDoViewController

- (void)viewWillAppear{
    [self filterTasksByPriority];
    [self.toDoTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    toDoList = [NSMutableArray new];
    self.taskes = [NSMutableArray array];
    _toDoTable.delegate = self;
    _toDoTable.dataSource = self;
    _searchBar.delegate = self;
        
//    highFilteredList = [NSMutableArray array];
//    midFilteredList  = [NSMutableArray array];
//    lowFilteredList  = [NSMutableArray array];
//    
    [self loadTasksFromUserDefaults];
    [self filterTasksByPriority];
    self.taskes = toDoList;
}

- (void)filterTasksByPriority {
    highFilteredList = [NSMutableArray array];
    midFilteredList  = [NSMutableArray array];
    lowFilteredList  = [NSMutableArray array];
    
    for (NewTask *task in toDoList) {
            if ([task.priority isEqualToString:@"High"]) {
                        [highFilteredList addObject:task];
                    } 
            else if ([task.priority isEqualToString:@"Medium"]) {
                        [midFilteredList addObject:task];
                    } 
            else if ([task.priority isEqualToString:@"Low"]) {
                        [lowFilteredList addObject:task];
                    }
            }
        NSLog(@"Filtered List - highFilteredList: %@", highFilteredList);
        NSLog(@"Filtered List - Medium Priority: %@", midFilteredList);
        [self.toDoTable reloadData];
}

- (IBAction)addTask:(id)sender {
    
    addTaskViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:@"AddTaskViewController"];
       
    addTaskViewController.insertNewItem = self;
        
    [self.navigationController pushViewController:addTaskViewController animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [toDoList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
        
       // Configure the cell...

    NewTask *newTask = toDoList[indexPath.row];
    cell.textLabel.text = newTask.name;
    
    NSLog(@"newTask.name:%@",newTask.name);
    NSLog(@"newTask.name:%@",newTask.status);
    
    if ([newTask.priority isEqualToString:@"High"]) {
            cell.imageView.image = [UIImage imageNamed:@"high"];
        } else if ([newTask.priority isEqualToString:@"Medium"]) {
            cell.imageView.image = [UIImage imageNamed:@"mid"];
        } else if ([newTask.priority isEqualToString:@"Low"]) {
            cell.imageView.image = [UIImage imageNamed:@"low"];
        }
        
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    printf("%ld  %ld\n",(long)indexPath.row,(long)indexPath.section);
    NewTask *selectedTask = toDoList[indexPath.row];
    detailViewController.taskObject = selectedTask;
    detailViewController.index= indexPath.row;
    detailViewController.update=self;
    [self.navigationController pushViewController:detailViewController animated:YES];
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Delete task?" preferredStyle:UIAlertControllerStyleActionSheet];
            
            
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [_taskes removeObjectAtIndex:indexPath.row];
                [toDoList removeObjectAtIndex:indexPath.row];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:_taskes];
                [defaults setObject:encodedData forKey:@"ToDoListTasks"];
                
                [self.toDoTable reloadData];
                
            }];
        
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
            [alert addAction:confirmAction];
            [alert addAction:cancelAction];
            
        
            [self presentViewController:alert animated:YES completion:nil];
        }
    }


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"ToDo:";
}


- (void)insertTask:(NewTask *)newTaskObject{
    //[toDoList addObject:newTaskObject];
    //[self.toDoTable reloadData];
    [self loadTasksFromUserDefaults];
    [self filterTasksByPriority];
}


- (void)loadTasksFromUserDefaults {
    toDoList = [NSMutableArray new];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *tasksData = [defaults objectForKey:@"ToDoListTasks"];
    
    if (tasksData !=nil) {
        NSMutableArray *tasksArray = [NSKeyedUnarchiver unarchiveObjectWithData:tasksData];
//        if ([tasksArray count] != 0) {
            //[toDoList addObjectsFromArray:tasksArray];
            
            for(int i=0;i<[tasksArray count];i++){
                NewTask *newTask = tasksArray[i];
                if([newTask.status isEqualToString:@"0"]){
                    [toDoList addObject:newTask];
                }
                
            }
            
            //toDoList = tasksArray;
            [self.toDoTable reloadData];
       // }
    }
}

- (IBAction)checkPriority:(id)sender {
    NSNumber *periortyNum = [[NSNumber alloc] initWithInteger:_priority.selectedSegmentIndex];

        switch (periortyNum.intValue) {
                 case 0:
                     toDoList = highFilteredList;
                NSLog(@"high Priority Filtered List: %@", highFilteredList);
                
                     break;
                 case 1:
                     toDoList = midFilteredList;
                NSLog(@"Medium Priority Filtered List: %@", midFilteredList);
                     break;
                 case 2:
                     toDoList = lowFilteredList;
                NSLog(@"low Priority Filtered List: %@", lowFilteredList);
                     break;
                default:
                     break;
             }
        
        [self.toDoTable reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length == 0) {
        switch (_priority.selectedSegmentIndex)
        {
            case 0 :
                toDoList = highFilteredList;
                break;
            case 1 :
                toDoList = midFilteredList;
                break;
            case 2:
                toDoList = lowFilteredList;
                break;
            default:
                break;
        }
    }
    
    else {
       
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchText];
        
            switch (_priority.selectedSegmentIndex)
            {
                case 0 :
                    toDoList = [[highFilteredList filteredArrayUsingPredicate:predicate] mutableCopy];
                    break;
                    
                case 1 :
                    toDoList = [[midFilteredList filteredArrayUsingPredicate:predicate] mutableCopy];
                    break;
                    
                case 2:
                    toDoList = [[lowFilteredList filteredArrayUsingPredicate:predicate] mutableCopy];
                    break;
                default:
                    break;
            }
        }
    
    [self.toDoTable reloadData];
}


@end
