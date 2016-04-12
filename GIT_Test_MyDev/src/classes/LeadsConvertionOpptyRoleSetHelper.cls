public class LeadsConvertionOpptyRoleSetHelper {
     
// Sets default values on the Opportunity and Opportunity Contact Role record created during Conversion. Called on AFTER UPDATE
public void SetContactRoleDefaults(Lead[] leads, map<ID,Lead> old_leads) 
{
     
    set<ID> set_opptyIDs = new set<ID>();
                 
    // Get Opportunity IDs into a Set if the lead was just converted and an Opportunity was created
    for (Lead l:leads){
        if (l.IsConverted && !old_leads.get(l.id).IsConverted){
            if (l.ConvertedOpportunityId != null){
                set_opptyIDs.add(l.ConvertedOpportunityId);
            }
        }
    }
     
    // Update Opportunity Contact Roles
    list<OpportunityContactRole> list_opptyContactRolesToUpdate = new list<OpportunityContactRole>();
    for(OpportunityContactRole ocr:[select Id,IsPrimary,Role from OpportunityContactRole where OpportunityId in :set_opptyIDs]) { 
        ocr.IsPrimary = true;
        ocr.Role = 'Decision Maker'; // set to what you want defaulted
        System.debug('**** setting role in helper');
        list_opptyContactRolesToUpdate.add(ocr);
    }
     
    if (list_opptyContactRolesToUpdate.size() > 0) {
        update list_opptyContactRolesToUpdate;
    }
     
}
 
}