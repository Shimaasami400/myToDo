//
//  AddTaskViewController.m
//  ToDoList
//
//  Created by Shimaa on 02/04/2024.
//

#import "AddTaskViewController.h"
#import "NewTask.h"

@interface AddTaskViewController (){
    NSMutableData *notes;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *priorityTxt;
@property (weak, nonatomic) IBOutlet UITextField *descTxt;
@property (weak, nonatomic) IBOutlet UISegmentedControl *PrioritySegment;

@end

@implementation AddTaskViewController
{
    NSUserDefaults *myDefaults;
    NSData *defaultTasks;
    NSMutableArray <NewTask *> *tasksArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    myDefaults = [NSUserDefaults standardUserDefaults];
    defaultTasks = [myDefaults objectForKey:@"ToDoListTasks"];
    if (defaultTasks != nil) {
        tasksArr = [NSKeyedUnarchiver unarchiveObjectWithData:defaultTasks];
    } else {
        tasksArr = [NSMutableArray new];
    }
}

- (IBAction)addNewItem:(id)sender {
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    NSNumber *statusNum = [[NSNumber alloc] initWithInteger:0];
    NSNumber *periortyNum = [[NSNumber alloc] initWithInteger:_PrioritySegment.selectedSegmentIndex];
    
    
    NewTask *newTask = [NewTask new];
    newTask.name = _nameTxt.text;
    newTask.desc = _descTxt.text;
    newTask.date = dateString;
    //NSLog(@"Date String: %@", dateString);
    newTask.status = [statusNum stringValue];
    NSLog(@"newTask.status: %@", newTask.status);
    NSString *xs=[NSString new];
    
    int checkPirorityValue = periortyNum.intValue;
        switch (checkPirorityValue) {
            case 0:
                xs = @"High";
                break;
            case 1:
                xs = @"Medium";
                printf("clicked");
                
                break;
            case 2:
                xs = @"Low";
                break;
            default:
                xs = @"High";
                break;
        }

    
    newTask.priority=xs;
    [tasksArr addObject:newTask];
    
    NSData *defaultTasksData = [NSKeyedArchiver archivedDataWithRootObject:tasksArr];
    [myDefaults setObject:defaultTasksData forKey:@"ToDoListTasks"];
    
    [_insertNewItem insertTask:newTask];
    
    BOOL synchronizeResult = [myDefaults synchronize];
    NSLog(@"UserDefaults synchronization result: %@", synchronizeResult ? @"Success" : @"Failed");
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
