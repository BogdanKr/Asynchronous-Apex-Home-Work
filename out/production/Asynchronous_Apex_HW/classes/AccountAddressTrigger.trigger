/**
 * Created by Bogdan on 12.09.2020.
 */

trigger AccountAddressTrigger on Account (after insert, after update, before insert, before update) {
    AccountTriggerHandler accountTriggerHandler = new AccountTriggerHandler();

    if (Trigger.isBefore && Trigger.isInsert) {
        System.debug('Trigger execution beforeInsert');
        System.debug('IsExecuting: ' + Trigger.isExecuting);
        accountTriggerHandler.beforeInsert(Trigger.new);
    }

    if (Trigger.isAfter && Trigger.isInsert) {
        System.debug('Trigger execution afterInsert');
        accountTriggerHandler.afterInsert(Trigger.new);
    }

    if (Trigger.isBefore && Trigger.isUpdate) {
        System.debug('Trigger execution beforeUpdate');
        accountTriggerHandler.beforeUpdate(Trigger.new);
    }

    if (Trigger.isAfter && Trigger.isUpdate) {
        System.debug('Trigger execution afterUpdate');
        accountTriggerHandler.afterUpdate(Trigger.new);
    }



}


//    Let’s write a SOQL query that returns all accounts in this trigger that don’t have related opportunities.
//    [SELECT Id,Name FROM Account WHERE Id IN :Trigger.New AND Id NOT IN (SELECT AccountId FROM Opportunity)]