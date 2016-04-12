@IsTest
private class LeadsConvertionOpptyRoleSetHelper_Test {
 
static testMethod void SetContactRoleDefaults_Test() {
     
    // Create a Lead
    Lead l = new Lead();
    l.lastname = 'Lastname';
    l.firstname = 'FirstName';
    l.company = 'Company';
    insert l;
     
    // Convert the Lead
    Database.LeadConvert lc = new database.LeadConvert();
    lc.setLeadId(l.id);
     
    LeadStatus convertStatus = [Select Id, MasterLabel from LeadStatus where IsConverted=true limit 1];
    System.debug('**** convertStatus.MasterLabel = ' + convertStatus.MasterLabel);
    lc.setConvertedStatus(convertStatus.MasterLabel);
     
    Database.LeadConvertResult lcr = Database.convertLead(lc);
    System.debug('*** lcr.isSuccess() = ' + lcr.isSuccess());
    System.assert(lcr.isSuccess());
     
    // Query Contact Role Records and Asserts all was set correctly.
    for (OpportunityContactRole ocr:[select Id,IsPrimary,Role from OpportunityContactRole where OpportunityId = :lcr.getOpportunityId()]){
        system.AssertEquals('Decision Maker', ocr.Role);
        system.AssertEquals(true, ocr.IsPrimary);
    }
     
}
 
}