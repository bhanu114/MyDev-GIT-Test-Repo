trigger HospitalDocterBefore on Hospitals_and_Doctor__c (before insert) {
    List<Hospitals_and_Doctor__c> hadNameList = [Select ExternalName__c From Hospitals_and_Doctor__c];
    Set<String> hadExternalList = new Set<String>();
    for(Hospitals_and_Doctor__c had : hadNameList){
        hadExternalList.add(had.ExternalName__c);
    }
    System.debug('***** hadExternalList = ' + hadExternalList);
    for(Hospitals_and_Doctor__c had : Trigger.new){
        System.debug('**** Trigger External = ' + had.Hospital__c + '-' + had.Doctor__c);
        System.debug('**** hadExternalList = ' + hadExternalList);
        if(hadExternalList.contains(had.ExternalName__c)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Duplicate Record creation'));    
            had.addError('Duplicate record');
            System.debug('**** Trying to create duplicate HAD');
            //ApexPages.addError(new 
        }else {
            System.debug('**** assigning the external value');
            had.ExternalName__c = had.Hospital__c + '-' + had.Doctor__c;
        }
    }
    
}