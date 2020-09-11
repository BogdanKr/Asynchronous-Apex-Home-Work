/**
 * Created by Bogdan on 11.09.2020.
 */

public with sharing class BatchIterableMethod implements Database.Batchable<Contact> {

    public Iterable<Contact> start(Database.BatchableContext param1) {
        return new MyCustomIterable();
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


    public with sharing class MyCustomIterable implements Iterable <Contact> {
        public Iterator<Contact> iterator() {
            return new MyIterator();
        }
    }


    public with sharing class MyIterator implements Iterator<Contact> {
        List<Contact> contacts { get; set; }
        Integer i { get; set; }


        public MyIterator() {
            contacts = [
                    SELECT Account.BillingStreet, Account.BillingCity, Account.BillingState,
                            Account.BillingCountry, Account.BillingPostalCode
                    FROM Contact
                    WHERE Is_Synced__c = FALSE
            ];
            i = 0;
        }

        public Boolean hasNext() {
            if (i >= contacts.size()) {
                return false;
            } else {
                return true;
            }
        }

        public Contact next() {
            // 100 is an arbitrary constant in this example
            // that represents the maximum size of the list.
            if (i == 100) {
                return null;
            }
            i++;
            return contacts[i - 1];
        }
    }


}