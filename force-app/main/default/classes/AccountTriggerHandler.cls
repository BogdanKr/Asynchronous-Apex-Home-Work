/**
 * Created by Bogdan on 22.09.2020.
 */

public with sharing class AccountTriggerHandler {

    public void beforeInsert(List<Account> accounts) {
       AccountTriggerAction.updateBillingPostalCode(accounts);
    }

    public void afterInsert(List<Account> accounts) {
        AccountTriggerAction.createSecondAccount(accounts[0]);

    }

    public void beforeUpdate(List<Account> accounts) {

    }

    public void afterUpdate(List<Account> accounts) {

    }
}