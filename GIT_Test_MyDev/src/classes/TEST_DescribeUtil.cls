public class TEST_DescribeUtil {
	
	public List<String> lstAccessFields {private set; get;}
    /*
	*	Method to accept object name and return only user accessible fields
	*/
	public List<SObject> getAccessbleFields(String sObjName) {
       /* Map<String, Schema.SobjectField> fields = 
            Schema.SobjectType.sObjName.fields.getMap();

        for (String s : fields.keySet()) {
            // Only include accessible fields 
            if (fields.get(s).getDescribe().isAccessible() && 
                fields.get(s).getDescribe().isCustom()) {
                    lstAccessFields.add(s);
            }
        }
        return lstAccessFields;*/
		return null;
    }//End - lstAccessFields
	
	 /*
	*	Method to accept list of object name and return list of Object related details
	*/
	public static Map<String, List<String>> getObjdetails(List<String> sObjTypes){
		Map<String,List<String>> mapSObj = new Map<String,List<String>>();
		List<String> lstSObjVals = new List<String>();
		// Make the describe call
		Schema.DescribeSobjectResult[] results = Schema.describeSObjects(sObjTypes);
		System.debug('Got describe information for ' + results.size() + ' sObjects.');
		// For each returned result, get some info
		for(Schema.DescribeSobjectResult res : results) {
			lstSObjVals.add(String.valueOf(res.fields.getMap().size()));
			
			System.debug('sObject Label: ' + res.getLabel());
			System.debug('Number of fields: ' + res.fields.getMap().size());
			System.debug(res.isCustom() ? 'This is a custom object.' : 'This is a standard object.');
			// Get child relationships
			Schema.ChildRelationship[] rels = res.getChildRelationships();
			if (rels.size() > 0) {
				lstSObjVals.add(res.getName() + ' has ' + rels.size() + ' child relationships.');
				System.debug(res.getName() + ' has ' + rels.size() + ' child relationships.');
			}
			mapSObj.put(res.getLabel(), lstSObjVals);
		}
		return mapSObj;
	}
}