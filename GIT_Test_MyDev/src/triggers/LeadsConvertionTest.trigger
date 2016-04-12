trigger LeadsConvertionTest on Lead (after update) {
     
    if(Trigger.isAfter && Trigger.isUpdate){
        LeadsConvertionOpptyRoleSetHelper  l = new LeadsConvertionOpptyRoleSetHelper();
        l.SetContactRoleDefaults(Trigger.new, Trigger.oldMap);
    }
 
}