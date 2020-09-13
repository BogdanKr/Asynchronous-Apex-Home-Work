/**
 * Created by Bogdan on 12.09.2020.
 */

trigger AccountAddressTrigger on Account (before insert, before update) {
    for (Account a : Trigger.new) {
        if (a.Match_Billing_Address__c && a.BillingPostalCode != null) {
            a.ShippingPostalCode = a.BillingPostalCode;
        }
    }
//    Let’s write a SOQL query that returns all accounts in this trigger that don’t have related opportunities.
//    [SELECT Id,Name FROM Account WHERE Id IN :Trigger.New AND Id NOT IN (SELECT AccountId FROM Opportunity)]
}