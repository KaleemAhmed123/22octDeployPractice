@isTest
public class DemoClass3_Test {

    @isTest
    static void testContactRecordsWithFilters() {
        // Step 1: Create test data
        List<Contact> testContacts = new List<Contact>();
        
        // Creating 5 contacts with different names and emails
        for (Integer i = 0; i < 5; i++) {
            testContacts.add(new Contact(
                LastName = 'Smith',
                FirstName = 'John' + i,
                Email = 'john' + i + '@example.com'
            ));
        }
        
        // Creating 5 more contacts with different names
        for (Integer i = 0; i < 5; i++) {
            testContacts.add(new Contact(
                LastName = 'Doe',
                FirstName = 'Jane' + i,
                Email = 'jane' + i + '@example.com'
            ));
        }

        insert testContacts; // Insert test data

        // Step 2: Call the method with different filter scenarios
        
        // Test case 1: Filter by last name "Smith"
        Test.startTest();
        List<Contact> smithContacts = DemoClass3.call(null, 'Smith', null, 10);
        Test.stopTest();
        
        // Assertions for case 1
        System.assertEquals(5, smithContacts.size(), 'Expected 5 contacts with last name "Smith"');
        for (Contact con : smithContacts) {
            System.assertEquals('Smith', con.LastName, 'LastName should be Smith');
        }

        // Test case 2: Filter by first name starting with "John"
        Test.startTest();
        List<Contact> johnContacts = DemoClass3.call('John', null, null, 10);
        Test.stopTest();
        
        // Assertions for case 2
        System.assertEquals(5, johnContacts.size(), 'Expected 5 contacts with first name starting with "John"');
        for (Contact con : johnContacts) {
            System.assert(con.FirstName.startsWith('John'), 'FirstName should start with John');
        }

        // Test case 3: Filter by email starting with "jane"
        Test.startTest();
        List<Contact> janeContacts = DemoClass3.call(null, null, 'jane', 10);
        Test.stopTest();
        
        // Assertions for case 3
        System.assertEquals(5, janeContacts.size(), 'Expected 5 contacts with email starting with "jane"');
        for (Contact con : janeContacts) {
            System.assert(con.Email.startsWith('jane'), 'Email should start with jane');
        }

        // Test case 4: Combined filters - First name "Jane" and last name "Doe"
        Test.startTest();
        List<Contact> combinedContacts = DemoClass3.call('Jane', 'Doe', null, 10);
        Test.stopTest();
        
        // Assertions for case 4
        System.assertEquals(5, combinedContacts.size(), 'Expected 5 contacts with first name "Jane" and last name "Doe"');
        for (Contact con : combinedContacts) {
            System.assertEquals('Doe', con.LastName, 'LastName should be Doe');
            System.assert(con.FirstName.startsWith('Jane'), 'FirstName should start with Jane');
        }

        // Test case 5: No filters should return 10 records
        Test.startTest();
        List<Contact> allContacts = DemoClass3.call(null, null, null, 10);
        Test.stopTest();
        
        // Assertions for case 5
        System.assertEquals(10, allContacts.size(), 'Expected 10 contacts when no filters are applied');
    }
}
