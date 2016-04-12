trigger BeforeCase on Case (before insert, before update) {
	//Map<String, Case> newCaseMap = new Map<String,Case>(Trigger.new);
	//EXECUTE ON BEFORE INSERT
    if(Trigger.isBefore && Trigger.isInsert){
		Boolean isRepeatable = true;
        Integer count = 0;
		if(isRepeatable){
			List<Case> cList = new List<Case>();
			Schema.DescribeSObjectResult caseObj = Case.SObjectType.getDescribe();
			For(Integer i=10;i<100;i++){
                count++;
				cList.add(new case(STATUS = 'Open', Origin ='Community', SUBJECT='PVR case : 2' ,DESCRIPTION = 'Testing Insert scenario of case :2'));
				System.debug('***** new Case in for loop ');
			}
			Database.insert(cList);
            if(count > 99){
				isRepeatable = false;
            }
		} else{
			//Get maximum allowed value
			Integer MAX_VALUE = 99;
			//Get current month number
			Date today = System.today();
			Integer month = today.month();
			//Get real count of cases created by user in a month
			Decimal monthCaseCount = [Select count() From Case where createdById =:UserInfo.getUserId() AND CALENDAR_MONTH(createdDate) =:month];
			System.debug('***** monthCaseCount ' + monthCaseCount);
			//Check whether case creation for user reached for month max
			for(Case c : Trigger.new){
				if(monthCaseCount > MAX_VALUE){
					c.addError('Maximum limit of case creation in a month for the user is reached');
				} else {
					System.debug('*** Case creation success');
				}
			}
		}
	}//END IS BEFORE INSERT
}