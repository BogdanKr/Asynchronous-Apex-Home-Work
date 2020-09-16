/**
 * Created by Bogdan on 16.09.2020.
 */

@RestResource(UrlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String accountId = request.requestURI.substringAfter('/Accounts/');
        accountId = accountId.substring(0, accountId.lastIndexOf('/'));

        Account result = [
                SELECT Id, Name, (SELECT Id, Name FROM Contacts)
                FROM Account
                WHERE Id = :accountId
        ];
        return result;
    }
}