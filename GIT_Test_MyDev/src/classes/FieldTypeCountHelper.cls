/*
*   Helper class for Field type count project
*/
global class FieldTypeCountHelper {
    
    public static List<FieldTypeWrapper> ftwList = null;
    
    public FieldTypeCountHelper(){}
    
    public static List<FieldTypeWrapper> perform(Set<String> objNameSet){

        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        Set<String> selctObjNamesSet = new Set<String>();
        Map<String, Schema.SObjectField> objectFieldMap = null;
        Map<String,Integer> mapTypeCount = null;
        Schema.DescribeFieldResult fd = null;
        Schema.DisplayType fldType = null;
        Map<String,List<Map<String,Integer>>>   mapObjFieldCount = new Map<String,List<Map<String,Integer>>>();// Map<ObjectName,List<Map<FieldType,totalCount>>>
        List<Map<String,Integer>> lstMapFieldsCount = new List<Map<String,Integer>>();
        ftwList = new List<FieldTypeWrapper>();
        FieldTypeWrapper ftw = null;
        
        for(String objName : objNameSet){
            selctObjNamesSet.add(objName);
        }
        //1. Declare counters
        
        for(String objName : selctObjNamesSet){
        System.debug('****** Object Name = ' + objName);
            ftw = new FieldTypeWrapper();
            ftw.objName = objName;
            objectFieldMap = globalDescribe.get(objName).getDescribe().fields.getMap();
            mapTypeCount = new Map<String,Integer>();
            
            for(String fieldName : objectFieldMap.keySet()){
                ftw.totalFCount++;
                fd = objectFieldMap.get(fieldName).getDescribe();
                fldType = fd.getType();
                ftw.usedFTypes.add(fd.getType());
                //System.debug('Name = ' + fd.getName() + ' FldType = ' + fd.getType());
                //Text count
                if(fd.getType() == Schema.DisplayType.String){//TEXT
                  ftw.textCount++;
                } 
                if(fd.getType() == Schema.DisplayType.Integer){//Integer
                  ftw.numberCount++;
                } 
                if(fd.getType()== Schema.DisplayType.String && fd.IsCalculated()) {//Formula
                   ftw.formulaCount++;
                }
                //Increase count for piclist
                if(fd.getType() == Schema.DisplayType.Picklist){//PICLIST
                  ftw.piclstCount++;
                }
                //Increase count for Boolean
                if(fd.getType() == Schema.DisplayType.Boolean){//CHECKBOX
                  ftw.booleanCount++;
                }
                //Increase count for Boolean
                if(fd.getType() == Schema.DisplayType.Currency){//CURRENCY
                  ftw.currencyCount++;
                }
                if(fd.getType() == Schema.DisplayType.Date){//DATE
                  ftw.dateCount++;
                }
                if(fd.getType() == Schema.DisplayType.DateTime){//DATETYME
                  ftw.dateTimeCount++;
                }
                if(fd.getType() == Schema.DisplayType.Phone){//PHONE
                  ftw.phoneCount++;
                }
                if(fd.getType() == Schema.DisplayType.Combobox){//Combobox
                  ftw.comboboxCount++;
                }
                if(fd.getType() == Schema.DisplayType.Double){//Double
                  ftw.doubleCount++;
                }
                if(fd.getType() == Schema.DisplayType.Email){//Email
                  ftw.emailCount++;
                }
                if(fd.getType() == Schema.DisplayType.EncryptedString){//EncryptedString
                  ftw.encryptedStringCount++;
                }
                if(fd.getType() == Schema.DisplayType.ID){//ID
                  ftw.idCount++;
                }
                if(fd.getType() == Schema.DisplayType.MultiPicklist){//MultiPicklist
                  ftw.multiPicklistCount++;
                }
                if(fd.getType() == Schema.DisplayType.Percent){//Percent
                  ftw.percentCount++;
                }
                if(fd.getType() == Schema.DisplayType.Reference){//Reference
                  ftw.referenceCount++;
                }
                if(fd.getType() == Schema.DisplayType.TextArea){//TextArea
                  ftw.textAreaCount++;
                }
                if(fd.getType() == Schema.DisplayType.Time){//Time
                  ftw.timeCount++;
                }
                if(fd.getType() == Schema.DisplayType.URL){//URL
                  ftw.urlCount++;
                }
            }//End - inner for
            
            ftwList.add(ftw);
        }//End - Out for
        /*for(String objName : mapObjFieldCount.keySet()){
            System.debug('*** ' + objName + 'Fields = ' + mapObjFieldCount.get(objName));
        }*/
        
        /*for(FieldTypeWrapper ftw1 : ftwList){
            System.debug('*** objName= ' + ftw1.objName + ' : ftw1.formulaCount = ' + ftw1.formulaCount + ' : ftw1.numberCount = ' + ftw1.numberCount + ' : ftw1.numberCount = ' + ftw1.numberCount + ' ftw1.booleanCount = ' + ftw1.booleanCount + ' : ftw1.numberCount = ' + ftw1.numberCount);
        }*/
        return ftwList;
    }
    //Wrapper class
    public class FieldTypeWrapper {
        public String objName {set;get;}
        public Set<Schema.DisplayType> usedFTypes{set;get;}
        public Integer totalFCount{set;get;}
        
        public FieldData textFData {set;get;}
        public Integer textCount{set;get;}
        public Integer formulaCount {set;get;}
        public Integer numberCount {set;get;}
        public Integer piclstCount {set;get;}
        public Integer booleanCount{set;get;}
        public Integer currencyCount{set;get;}
        public Integer dateCount{set;get;}
        public Integer dateTimeCount{set;get;}
        public Integer doubleCount{set;get;}
        public Integer phoneCount{set;get;}
        public Integer comboboxCount{set;get;}
        public Integer emailCount{set;get;}
        public Integer encryptedStringCount {set;get;}
        public Integer idCount {set;get;}
        public Integer multiPicklistCount {set;get;}
        public Integer percentCount {set;get;}
        public Integer referenceCount {set;get;}
        public Integer textAreaCount {set;get;}
        public Integer timeCount {set;get;}
        public Integer urlCount {set;get;}
        
        //Default constructer to set default values to all properties
        public FieldTypeWrapper(){
            objName = '';
            usedFTypes = new Set<Schema.DisplayType>();
            totalFCount = 0;
            
            textCount = 0;
            formulaCount = 0;
            numberCount = 0;
            piclstCount = 0;
            booleanCount = 0;
            currencyCount = 0;
            dateCount = 0;
            dateTimeCount = 0;
            doubleCount = 0;
            phoneCount = 0;
            comboboxCount = 0;
            emailCount = 0;
            encryptedStringCount = 0;
            idCount = 0;
            multiPicklistCount = 0;
            percentCount = 0;
            referenceCount = 0;
            textAreaCount = 0;
            timeCount = 0;
            urlCount = 0;
        }
    }
    public class FieldData {
        public String fType{set;get;}
        public Integer fCount {set;get;}
    }
}
/*
anytype                     Any value of the following types: String, Picklist, Boolean, Integer, Double, Percent, ID, Date, DateTime, URL, or Email.
base64                      Base64-encoded arbitrary binary data (of type base64Binary)
Boolean                     Boolean (true or false) values
Combobox                    Comboboxes, which provide a set of enumerated values and allow the user to specify a value not in the list
Currency                    Currency values
DataCategoryGroupReference  Reference to a data category group or a category unique name.
Date                        Date values
DateTime                    DateTime values
Double                      Double values
Email                       Email addresses
EncryptedString             Encrypted string
ID                          Primary key field for an object
Integer                     Integer values
MultiPicklist               Multi-select picklists, which provide a set of enumerated values from which multiple values can be selected
Percent                     Percent values
Phone                       Phone numbers. Values can include alphabetic characters. Client applications are responsible for phone number formatting.
Picklist                    Single-select picklists, which provide a set of enumerated values from which only one value can be selected
Reference                   Cross-references to a different object, analogous to a foreign key field
String                      String values
TextArea                    String values that are displayed as multiline text fields
Time                        Time values
URL                         URL values that are displayed as hyperlinks
*/