/*
*    Created to test practicing web-services
*/
global class WebServiceClass {

/*
*    This class Validates Account ID
*/
    webservice static Boolean validateAccount(ID accId){
        
        return ([SELECT Id, Name FROM Account WHERE Id =: accId] != null);
    }
}