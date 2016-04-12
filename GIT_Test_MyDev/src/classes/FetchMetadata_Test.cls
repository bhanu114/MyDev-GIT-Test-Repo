/*
*    Test class for FetchMetadata class
*/@isTest
private class FetchMetadata_Test {

    private static testMethod void testconnectMetadata(){
        FetchMetadata fm = new FetchMetadata();
        fm.connectMetadata();
        System.assertEquals(fm,null);
    }
}