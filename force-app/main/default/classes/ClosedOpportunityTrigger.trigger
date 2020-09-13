/**
 * Created by Bogdan on 13.09.2020.
 */

trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task> addTasks = new List<Task>();
    for (Opportunity opp : [SELECT Id FROM Opportunity WHERE Id IN :Trigger.new AND StageName = 'Closed Won']) {
        addTasks.add(new Task(Subject = 'Follow Up Test Task', WhatId = opp.Id));
    }
    insert addTasks;
}