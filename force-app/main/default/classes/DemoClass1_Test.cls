@isTest
public class DemoClass1_Test {

    @isTest
    static void testAccountCreationSuccess() {
        // Test case for successful account creation
        
        Test.startTest();
        
        // Call the method with valid parameters
        Account testAcc = DemoClass1.call(
            'Test Account',       // Name
            'Hot',                // Rating
            '1234567890',         // Phone
            'www.test.com',       // Website
            Date.today(),         // Last Purchase Date
            true                  // Is Intel
        );
        
        Test.stopTest();
        
        // Assert the account is inserted successfully and returned with correct values
        Account insertedAcc = [SELECT Name, Phone, Website, Rating, Last_Purchase_Date__c, Is_Intel__c 
                               FROM Account 
                               WHERE Id = :testAcc.Id];
        
        System.assertEquals('Test Account', insertedAcc.Name);
        System.assertEquals('1234567890', insertedAcc.Phone);
        System.assertEquals('www.test.com', insertedAcc.Website);
        System.assertEquals('Hot', insertedAcc.Rating);
        System.assertEquals(Date.today(), insertedAcc.Last_Purchase_Date__c);
        System.assertEquals(true, insertedAcc.Is_Intel__c);
    }

    @isTest
    static void testAccountCreationFailure() {
        // Test case for failed account creation due to missing Name (required field)

        Test.startTest();
        try {
            // Calling the method with invalid data (no Name provided)
            Account invalidAcc = DemoClass1.call(
                null,                // Name is null (this should cause a DML exception)
                'Cold',              // Rating
                '0987654321',        // Phone
                'www.invalid.com',   // Website
                Date.today(),        // Last Purchase Date
                false                // Is Intel
            );
            System.assert(false, 'Expected a DMLException but did not get one.');
        } catch (AuraHandledException e) {
            // Assert that the correct exception message is thrown
            System.assert(e.getMessage().contains('Account creation failed: Required fields are missing'));
        }
        Test.stopTest();
    }

    @isTest
    static void testEdgeCaseWithNullValues() {
        // Test case to handle null values for optional fields
        
        Test.startTest();
        
        // Call the method with null values for optional fields like phone, website, etc.
        Account edgeAcc = DemoClass1.call(
            'Edge Case Account',  // Name
            null,                 // Rating (can be null)
            null,                 // Phone (null allowed)
            null,                 // Website (null allowed)
            null,                 // Last Purchase Date (null allowed)
            false                 // Is Intel
        );
        
        Test.stopTest();
        
        // Assert that account is created with null values for those fields
        Account insertedEdgeAcc = [SELECT Name, Phone, Website, Rating, Last_Purchase_Date__c, Is_Intel__c 
                                   FROM Account 
                                   WHERE Id = :edgeAcc.Id];
        
        System.assertEquals('Edge Case Account', insertedEdgeAcc.Name);
        System.assertEquals(null, insertedEdgeAcc.Phone);
        System.assertEquals(null, insertedEdgeAcc.Website);
        System.assertEquals(null, insertedEdgeAcc.Rating);
        System.assertEquals(null, insertedEdgeAcc.Last_Purchase_Date__c);
        System.assertEquals(false, insertedEdgeAcc.Is_Intel__c);
    }
}
