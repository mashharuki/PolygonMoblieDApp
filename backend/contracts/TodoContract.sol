//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract TodoContract {
  // counter for task id
  uint256 public taskCount = 0;
  // struct for task
  struct Task {
      uint256 index;
      string taskName;
      bool isComplete;
  }
  // map for id & Task
  mapping(uint256 => Task) public todos;
  
  // event
  event TaskCreated(string task, uint256 taskNumber);
  event TaskUpdated(string task, uint256 taskId);
  event TaskIsCompleteToggled(string task, uint256 taskId, bool isComplete);
  event TaskDeleted(uint256 taskNumber);

  /**
   * create task func
   */
  function createTask(string memory _taskName) public {
    // create new task
    todos[taskCount] = Task(taskCount, _taskName, false);
    taskCount++;

    emit TaskCreated(_taskName, taskCount - 1);
  }

  /**
   * Update task func  
   */
  function updateTask(uint256 _taskId, string memory _taskName) public {
    // get task data
    Task memory currTask = todos[_taskId];
    // update!!
    todos[_taskId] = Task(_taskId, _taskName, currTask.isComplete);

    emit TaskUpdated(_taskName, _taskId);
  }

  /**
   * change task state func
   */
  function toggleComplete(uint256 _taskId) public {
    // get task data
    Task memory currTask = todos[_taskId];
    // update task state
    todos[_taskId] = Task(_taskId, currTask.taskName, !currTask.isComplete);

    emit TaskIsCompleteToggled(currTask.taskName, _taskId, !currTask.isComplete);
  }

  /**
   * delete task func
   */  
  function deleteTask(uint256 _taskId) public {
    // delete task
    delete todos[_taskId];
    emit TaskDeleted(_taskId);
  }
}
