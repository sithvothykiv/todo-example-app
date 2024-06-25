
# Todos App

## Overview

The App is a Flutter mobile application example assignment to complete the first exam.

## Features

- [x] **Create New Task:** Add new tasks with titles, descriptions, start and end dates range.
- [x] **Edit and Delete Tasks:** Tasks created can be edited and deleted.
- [x] **Sort:** Sort tasks by date or completion status.
- [x] **Mark as Complete:** Mark task items as completed.
## Todo
- [ ] **Set Priority Task:** Set task items to priority task.
- [ ] **Dashboard Preview:** User personal dashboard to preview on graph.

## Getting Started

### State Management
The app uses the Bloc architecture for efficient state management. Key Bloc classes include:

- TasksBloc: Manages the overall state of tasks in the application.
- TasksEvent: Represents events triggering state changes.
- TasksState: Represents different states of the tasks, such as loading, success, or failure.

### Error Handling
Error handling is implemented throughout the app to ensure a seamless user experience. states provide details about errors encountered during data loading, task creation, and task updates.

 - LoadTaskFailure
 - AddTaskFailure
 - UpdateTaskFailure


### Unit Test
Unit test has been integrated to test all functionalities from initial state
 - Creating task
 - Updating task
 - Deleting task


### Integration Test
Test to verify the widget
 - Creating task
 - Updating task
 - Deleting task
