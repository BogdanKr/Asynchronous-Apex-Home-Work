/**
 * Created by Bogdan on 16.09.2020.
 */
@IsTest
public with sharing class AccountManagerTest {
    @IsTest
    static void testGetAccountById() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestURI =
                'https:/cunning-fox-2asnae-dev-ed.lightning.force.com/services/apexrest/Accounts/' + recordId + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('Test record', thisAccount.Name);
        System.assertEquals(thisAccount.Contacts.size(), 1);
        System.assertEquals(thisAccount.Contacts[0].Name, 'TestContact');
//        System.debug(thisAccount.Contacts[0].Name);
    }

    static Id createTestRecord() {
        // Create test record
        Account accountTest = new Account(
                Name = 'Test record');
        insert accountTest;
        Contact contactTest = new Contact(LastName = 'TestContact', AccountId = accountTest.Id);
        insert contactTest;
        return accountTest.Id;
    }
}