//
//  NewTask.m
//  ToDoList
//
//  Created by Shimaa on 02/04/2024.
//

#import "NewTask.h"

@implementation NewTask

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:@"name"];
        _desc = [coder decodeObjectForKey:@"desc"];
        _priority = [coder decodeObjectForKey:@"priority"];
        _status = [coder decodeObjectForKey:@"status"];
        _date =  [coder decodeObjectForKey:@"date"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_desc forKey:@"desc"];
    [coder encodeObject:_priority forKey:@"priority"];
    [coder encodeObject:_status forKey:@"status"];
    [coder encodeObject:_date forKey:@"date"];
}

@end
