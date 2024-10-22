@isTest
public class DemoClass2_Test {

    @isTest
    static void testRetrieveContacts() {
        // Step 1: Create test data
        List<Contact> testContacts = new List<Contact>();
        
        for (Integer i = 0; i < 12; i++) { // Create 12 contacts
            testContacts.add(new Contact(
                LastName = 'Test LastName ' + i,
                FirstName = 'Test FirstName ' + i,
                Email = 'test' + i + '@example.com',
                Phone = '123-456-789' + i
            ));
        }
        
        insert testContacts; // Insert test data into the database

        // Step 2: Call the method
        Test.startTest();
        List<Contact> retrievedContacts = DemoClass2.call();
        Test.stopTest();

        // Step 3: Assertions
        System.assertEquals(10, retrievedContacts.size(), 'Expected to retrieve 10 contacts');

        // Check that the retrieved contacts are the expected ones
        for (Integer i = 0; i < 10; i++) {
            System.assertEquals('Test LastName ' + i, retrievedContacts[i].LastName, 'LastName mismatch at index ' + i);
            System.assertEquals('Test FirstName ' + i, retrievedContacts[i].FirstName, 'FirstName mismatch at index ' + i);
            System.assertEquals('test' + i + '@example.com', retrievedContacts[i].Email, 'Email mismatch at index ' + i);
            System.assertEquals('123-456-789' + i, retrievedContacts[i].Phone, 'Phone mismatch at index ' + i);
        }
    }
}
