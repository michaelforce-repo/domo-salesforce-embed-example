@isTest
private class domoEmbedExampleTests {
    
    @isTest static void testOne() {
        
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new domoEmbedExampleMock());
        
        // Test instantiation of controller class
        domoEmbedExampleController domo = new domoEmbedExampleController();

        // Confirm we have an embed token
        system.assert(!String.isBlank(domo.embedToken));
    }
}