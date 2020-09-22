/**
 * Created by Bogdan on 22.09.2020.
 */

public with sharing class AccountTriggerAction {
    private static Boolean isSecondAccCreated = false;

    public static void updateBillingPostalCode(List<Account> accounts) {
        System.debug('AccountTriggerAction');
        for (Account a : accounts) {
            a.ShippingPostalCode = a.BillingPostalCode;
        }
    }

    public static void createSecondAccount(Account acc) {
        if (!isSecondAccCreated) {
            isSecondAccCreated = true;
            Account newAcc = new Account(Name = 'Name: ' + acc.Id, BillingPostalCode = '00000');
            insert newAcc;
            System.debug('Second account has been created');
        }

    }
}