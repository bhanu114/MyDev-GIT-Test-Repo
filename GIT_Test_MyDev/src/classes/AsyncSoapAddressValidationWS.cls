//Generated by wsdl2apex

public class AsyncSoapAddressValidationWS {
    public class ValidateAddressesResponseFuture extends System.WebServiceCalloutFuture {
        public SoapAddressValidationWS.validationResultSOAP[] getValue() {
            SoapAddressValidationWS.ValidateAddressesResponse response = (SoapAddressValidationWS.ValidateAddressesResponse)System.WebServiceCallout.endInvoke(this);
            return response.return_x;
        }
    }
    public class AsyncValidateAddressesPort {
        public String endpoint_x = 'http://trg-mock-address-validator.herokuapp.com:80/soap/validateAddresses';
        public Map<String,String> inputHttpHeaders_x;
        public String clientCertName_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://SOAP.webservices.cdev.salesforce.com/', 'SoapAddressValidationWS'};
        public AsyncSoapAddressValidationWS.ValidateAddressesResponseFuture beginValidateAddresses(System.Continuation continuation,SoapAddressValidationWS.addressSOAP[] Address) {
            SoapAddressValidationWS.ValidateAddresses request_x = new SoapAddressValidationWS.ValidateAddresses();
            request_x.Address = Address;
            return (AsyncSoapAddressValidationWS.ValidateAddressesResponseFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncSoapAddressValidationWS.ValidateAddressesResponseFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://SOAP.webservices.cdev.salesforce.com/',
              'ValidateAddresses',
              'http://SOAP.webservices.cdev.salesforce.com/',
              'ValidateAddressesResponse',
              'SoapAddressValidationWS.ValidateAddressesResponse'}
            );
        }
    }
}