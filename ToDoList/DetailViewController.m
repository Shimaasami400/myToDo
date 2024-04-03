//
//  DetailViewController.m
//  ToDoList
//
//  Created by Shimaa on 03/04/2024.
//

#import "DetailViewController.h"


@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *piroritySegment;
@property (weak, nonatomic) IBOutlet UILabel *dateTxt;
@property (weak, nonatomic) IBOutlet UITextField *descTxt;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUIWithTaskDetails];
    
}

- (void)viewWillAppear:(BOOL)animated{
    _nameTxt.text = _taskObject.name;
    NSLog(@"Task Description: %@", self.taskObject.desc);
    self.descTxt.text = _taskObject.desc;
    [self updateUIWithTaskDetails];
    
}

- (void)updateUIWithTaskDetails {
    if (self.taskObject) {
            self.nameTxt.text = self.taskObject.name;
            self.descTxt.text = self.taskObject.desc;
            self.dateTxt.text = self.taskObject.date;
            
            if ([self.taskObject.priority isEqualToString:@"High"]) {
                self.piroritySegment.selectedSegmentIndex = 0;
            } else if ([self.taskObject.priority isEqualToString:@"Medium"]) {
                self.piroritySegment.selectedSegmentIndex = 1;
            } else if ([self.taskObject.priority isEqualToString:@"Low"]) {
                self.piroritySegment.selectedSegmentIndex = 2;
            }
        
        if([self.taskObject.status isEqualToString:@"ToDo"]){
            self.statusSegment.selectedSegmentIndex = 0;
        }
        else if([self.taskObject.status isEqualToString:@"Doing"]){
            self.statusSegment.selectedSegmentIndex = 1;
        }
        else if([self.taskObject.status isEqualToString:@"Done"]){
            self.statusSegment.selectedSegmentIndex = 2;
        }
            
        }
}


- (IBAction)updatetask:(id)sender {
    NewTask *updatedTask;
    printf("Update task button");
    printf("index = %d",_index);
   // if (self.index != 0) {
        printf("if statement");
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSData *tasksData = [defaults objectForKey:@"ToDoListTasks"];
        NSMutableArray *tasksArray = [NSKeyedUnarchiver unarchiveObjectWithData:tasksData];
        
        
        if (self.index < tasksArray.count) {
            
            NSString *updatedName = _nameTxt.text;
            NSString *updatedDesc = _descTxt.text;
            NSString *updatedPriority;
            NSString *statuePriority;
            
            switch (_piroritySegment.selectedSegmentIndex) {
                case 0:
                    updatedPriority = @"High";
                    break;
                case 1:
                    updatedPriority = @"Medium";
                    break;
                case 2:
                    updatedPriority = @"Low";
                    break;
                default:
                    break;
            }
            
            switch (_statusSegment.selectedSegmentIndex) {
                case 0:
                    statuePriority = @"0";
                    break;
                case 1:
                    statuePriority = @"1";
                    break;
                case 2:
                    statuePriority = @"2";
                    break;
                default:
                    break;
            }
            
            updatedTask = [NewTask new];
            updatedTask.name = updatedName;
            updatedTask.desc = updatedDesc;
            updatedTask.priority = updatedPriority;
            updatedTask.status = statuePriority;
            
        
           // [tasksArray replaceObjectAtIndex:self.index withObject:updatedTask];
            
            tasksArray [_index]  = updatedTask;
                        
            NSData *updatedTasksData = [NSKeyedArchiver archivedDataWithRootObject:tasksArray];
                        
            [defaults setObject:updatedTasksData forKey:@"ToDoListTasks"];
            [defaults synchronize];
            
            NSLog(@"Updated tasksArray: %@", tasksArray);
                        
            [self.navigationController popViewControllerAnimated:YES];
        }
    //}
    
    [self.update insertTask:updatedTask];
    
}

@end
