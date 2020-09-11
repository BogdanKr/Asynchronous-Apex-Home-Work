/**
 * Created by Bogdan on 11.09.2020.
 */

public with sharing class FutureMethodHW {
    @Future
    public static void changeContactFields() {
        List<Account> accounts = [SELECT Id, BillingAddress, (SELECT Id FROM Contacts) FROM Account LIMIT 150];
        List<Contact> contacts = new List<Contact>();
        for (Account acc : accounts) {
            if (acc.BillingAddress != null) {
                for (Contact contact : acc.Contacts){
                    contact.Is_Synced__c = false;
                    contact.Processed_By_Future__c = true;
                    contacts.add(contact);
                }
            }
        }
        update contacts;
        System.debug('Finish future method');
    }

}