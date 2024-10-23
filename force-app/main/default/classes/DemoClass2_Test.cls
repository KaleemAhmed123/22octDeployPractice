@isTest
private class DemoClass2_Test {
    @isTest
    static void testCreateAccount() {
        Account acc = DemoClass2.createAccount('Test Account for Kunal');
        System.assertNotEquals(null, acc.Id, 'Account was not created successfully.');
        System.assertEquals('Test Account', acc.Name, 'Account name did not match.');
    }

    @isTest
    static void testUpdateAccount() {
        Account acc = new Account(Name = 'Old Name');
        insert acc;

        acc.Name = 'Updated Name';
        DemoClass2.updateAccount(acc);
        
        Account updatedAcc = [SELECT Name FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Updated Name', updatedAcc.Name, 'Account name did not update successfully.');
    }
}
