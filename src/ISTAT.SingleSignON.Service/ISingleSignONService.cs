using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;

namespace ISTAT.SingleSignON.Service
{

    public interface ISingleSignONService
    {
      
        ISTATUser Login(LoginObj login);
        bool ChangePassword(PasswordObj passobj);
        bool ResetPassword(MailObject passobj);

        
        List<ISTATUser> GetUsers();
        ISTATUser GetUser(string UserCode);
        ISTATUser AddUser(ISTATUser user);
        ISTATUser ModUser(ISTATUser user);
        bool DelUser(ISTATUser user);

        Dictionary<string, List<MetadataObject>> GetMetadata(string Lang);



    }
   
}
