/**
 * Created by Bogdan on 11.09.2020.
 */

public with sharing class BatchableMethodHW implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext param1) {
        return Database.getQueryLocator('SELECT Account.BillingStreet, Account.BillingCity, ' +
                'Account.BillingState, Account.BillingCountry, Account.BillingPostalCode ' +
                'FROM Contact WHERE Is_Synced__c = false');
    }

    public void execute(Database.BatchableContext param1, List<Contact> contacts) {
        Set<Account> accounts = new Set<Account>();
        for (Contact contact : contacts) {
            if (contact.Account != null) {
                contact.MailingStreet = contact.Account.BillingStreet;
                contact.MailingCity = contact.Account.BillingCity;
                contact.MailingState = contact.Account.BillingState;
                contact.MailingPostalCode = contact.Account.BillingPostalCode;
                contact.MailingCountry = contact.Account.BillingCountry;
                contact.Account.Updated_By_Contact__c = true;
                contact.Is_Synced__c = true;
                accounts.add(contact.Account);
            }
        }
        List<Account> accountsToUpdate = new List<Account>(accounts);
        update accountsToUpdate;
        update contacts;
        System.debug('Execute batches_____');
    }

    public void finish(Database.BatchableContext param1) {
    }
}