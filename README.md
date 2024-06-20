
# Todos App

## Overview

The App is a Flutter mobile application example assignment to complete the first exam.

## Features

- **Create New Task:** Add new tasks with titles, descriptions, start and end dates.
- **Edit and Delete Tasks:** Tasks created can be edited and deleted.
- **Sort:** Sort tasks by date or completion status.
- **Mark as Complete:** Mark task items as completed.
- **Set Priority Task:** Set task items to priority task.
- **Dashboard Preview:** User personal dashboard to preview on graph.

## Getting Started

### State Management
The app uses the Bloc architecture for efficient state management. Key Bloc classes include:

TasksBloc: Manages the overall state of tasks in the application.
TasksEvent: Represents events triggering state changes.
TasksState: Represents different states of the tasks, such as loading, success, or failure.

### Error Handling
Error handling is implemented throughout the app to ensure a seamless user experience. 
The LoadTaskFailure, AddTaskFailure, and UpdateTaskFailure states provide details about errors encountered during data loading, task creation, and task updates.

### Unit Test
Unit test has been integrated to test all functionalities from initial state to creating new task, updating task and deleting task

### Integration Test
