public class FetchMetadata {
    
    public void connectMetadata(){
         PartnerService.soap soap = new PartnerService.soap();

    PartnerService.LoginResult login = soap.login('bhanu.jangam@sfdc.com','Thebhanu@123');
    }
}