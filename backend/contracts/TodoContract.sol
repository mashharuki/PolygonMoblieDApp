//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract TodoContract {
  
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

  
}
