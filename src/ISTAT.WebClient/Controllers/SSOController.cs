using ISTAT.WebClient.Models;
//using ISTAT.WebClient.WidgetComplements.Model.App_GlobalResources;
//using ISTAT.WebClient.WidgetEngine.WidgetBuild;
using System;
using System.Runtime.Serialization.Json;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
//using ISTAT.WebClient.WidgetComplements.Model.JSObject;
//using ISTAT.WebClient.WidgetComplements.Model.Settings;
using System.Configuration;
using ISTAT.SingleSignON;
using ISTAT.SingleSignON.Service;
using ISTAT.WebClient.WidgetComplements.Model.JSObject.Input;
using ISTAT.WebClient.WidgetComplements.Model.Enum;
using ISTAT.WebClient.WidgetEngine.WidgetBuild;

namespace ISTAT.WebClient.Controllers
{
    public class SSOController : Controller
    {
        private ControllerSupport CS = new ControllerSupport();

        private ConnectionStringSettings connectionStringSetting=ConfigurationManager.ConnectionStrings["ISTATWebClientSSO"];

        public ActionResult Login()
        {
            dynamic PostDataArrived = CS.GetPostData(this.Request);

            try
            {

                LoginObj loginObj = new LoginObj();
                loginObj.Email = (string)PostDataArrived.Email;
                loginObj.Password = (string)PostDataArrived.Password;
                SingleSignONService ssoService = new SingleSignONService();
                return CS.ReturnForJQuery(ssoService.Login(loginObj));
            }
            catch (Exception)
            {
                return CS.ReturnForJQuery(ControllerSupport.ErrorOccured);
            }
        }


        public ActionResult GetMetadata()
        {
            dynamic PostDataArrived = CS.GetPostData(this.Request);

            try
            {
                 Dictionary<string, List<MetadataObject>> metadatas = new Dictionary<string, List<MetadataObject>>();
                 string Lang = System.Threading.Thread.CurrentThread.CurrentCulture.TwoLetterISOLanguageName;        
                SingleSignONService ssoService = new SingleSignONService();
                metadatas = ssoService.GetMetadata(Lang);

                return CS.ReturnForJQuery(metadatas);
            }
            catch (Exception)
            {
                return CS.ReturnForJQuery(ControllerSupport.ErrorOccured);
            }
        }

        public ActionResult AddUser()
        {
            dynamic PostDataArrived = CS.GetPostData(this.Request);

            try
            {
                /*
                   public string Email { get; set; }
                        public string Password { get; set; }

                        public string UserCode { get; set; }
                        public string Name { get; set; }
                        public string Surname { get; set; }
                        public string Sex { get; set; }
                        public string Age { get; set; }
                        public string Country { get; set; }
                        public string Study { get; set; }
                        public string Position { get; set; }
                        public string Agency { get; set; }

                        public bool IsSA { get; set; }

                        public string Lang { get; set; }
                        public List<string> Themes { get; set; }
                                */
                ISTATUser istatUser = new ISTATUser();
                istatUser.Email = (string)PostDataArrived.Email;
                istatUser.Password = (string)PostDataArrived.Password;
                istatUser.UserCode = (string)PostDataArrived.UserCode;
                istatUser.Name = (string)PostDataArrived.Name;
                istatUser.Surname = (string)PostDataArrived.Surname;
                istatUser.Sex = (string)PostDataArrived.Sex;

                istatUser.Age = (string)PostDataArrived.Age;
                istatUser.Country = (string)PostDataArrived.Country;
                istatUser.Study = (string)PostDataArrived.Study;
                istatUser.Position = (string)PostDataArrived.Position;
                istatUser.Agency = (string)PostDataArrived.Agency;
                //istatUser.IsSA = (bool)PostDataArrived.IsSA;
                istatUser.IsSA = false;
                istatUser.Lang = (string)PostDataArrived.Lang;
                //istatUser.Themes = (string)PostDataArrived.Themes;


                SingleSignONService ssoService = new SingleSignONService();
                return CS.ReturnForJQuery(ssoService.AddUser(istatUser));
            }
            catch (Exception)
            {
                return CS.ReturnForJQuery(ControllerSupport.ErrorOccured);
            }
        }

        public ActionResult GetUser()
        {
            dynamic PostDataArrived = CS.GetPostData(this.Request);

            try
            {
                ISTATUser utenteIstat = new ISTATUser();
                string IdUser = PostDataArrived;
                SingleSignONService ssoService = new SingleSignONService();
                utenteIstat = ssoService.GetUser(IdUser);

                return CS.ReturnForJQuery(utenteIstat);
            }
            catch (Exception)
            {
                return CS.ReturnForJQuery(ControllerSupport.ErrorOccured);
            }
        }


        public ActionResult DelUser()
        {
            dynamic PostDataArrived = CS.GetPostData(this.Request);

            try
            {

                ISTATUser istatUser = new ISTATUser();
                istatUser.Email = (string)PostDataArrived.Email;
                istatUser.Password = (string)PostDataArrived.Password;
                istatUser.UserCode = (string)PostDataArrived.UserCode;
                istatUser.Name = (string)PostDataArrived.Name;
                istatUser.Surname = (string)PostDataArrived.Surname;
                istatUser.Sex = (string)PostDataArrived.Sex;

                istatUser.Age = (string)PostDataArrived.Age;
                istatUser.Country = (string)PostDataArrived.Country;
                istatUser.Study = (string)PostDataArrived.Study;
                istatUser.Position = (string)PostDataArrived.Position;
                istatUser.Agency = (string)PostDataArrived.Agency;
                //istatUser.IsSA = (bool)PostDataArrived.IsSA;
                istatUser.IsSA = false;
                istatUser.Lang = (string)PostDataArrived.Lang;
                //istatUser.Themes = (string)PostDataArrived.Themes;

                SingleSignONService ssoService = new SingleSignONService();
                bool utenteIstat = ssoService.DelUser(istatUser);

                return CS.ReturnForJQuery(utenteIstat);
            }
            catch (Exception)
            {
                return CS.ReturnForJQuery(ControllerSupport.ErrorOccured);
            }
        }

        public ActionResult GetUsers()
        {
            dynamic PostDataArrived = CS.GetPostData(this.Request);

            try
            {
                List<ISTATUser> utentiIstat = new List<ISTATUser>();
                string IdUser = PostDataArrived;
                SingleSignONService ssoService = new SingleSignONService();
                utentiIstat = ssoService.GetUsers();

                return CS.ReturnForJQuery(utentiIstat);
            }
            catch (Exception)
            {
                return CS.ReturnForJQuery(ControllerSupport.ErrorOccured);
            }
        }

        public ActionResult GetUserListOld()
        {
            try
            {
                List<ISTATUser> utentiIstat = new List<ISTATUser>();
                SingleSignONService ssoService = new SingleSignONService();
                utentiIstat = ssoService.GetUsers();

                return CS.ReturnForJQuery(utentiIstat);
            }
            catch (Exception)
            {
                return CS.ReturnForJQuery(ControllerSupport.ErrorOccured);
            }
        }

        public const string ProfileSession = "ProfileSession";
        
        public ActionResult ModUser()
        {
            dynamic PostDataArrived = CS.GetPostData(this.Request);

            try
            {
                ISTATUser istatUser = new ISTATUser();
                istatUser.Email = (string)PostDataArrived.Email;
                istatUser.Password = (string)PostDataArrived.Password;
                istatUser.UserCode = (string)PostDataArrived.UserCode;
                istatUser.Name = (string)PostDataArrived.Name;
                istatUser.Surname = (string)PostDataArrived.Surname;
                istatUser.Sex = (string)PostDataArrived.Sex;

                istatUser.Age = (string)PostDataArrived.Age;
                istatUser.Country = (string)PostDataArrived.Country;
                istatUser.Study = (string)PostDataArrived.Study;
                istatUser.Position = (string)PostDataArrived.Position;
                istatUser.Agency = (string)PostDataArrived.Agency;
                //istatUser.IsSA = (bool)PostDataArrived.IsSA;
                istatUser.IsSA = false;
                istatUser.Lang = (string)PostDataArrived.Lang;
                //istatUser.Themes = (string)PostDataArrived.Themes;
                //istatUser.Themes = new List<string>(PostDataArrived.Themes);
                istatUser.Themes = PostDataArrived.Themes.ToObject<List<string>>();

                SingleSignONService ssoService = new SingleSignONService();
                return CS.ReturnForJQuery(ssoService.ModUser(istatUser));
            }
            catch (Exception ex)
            {
                return CS.ReturnForJQuery(ControllerSupport.ErrorOccured);
            }
        }

        public ActionResult ChangePassword()
        {
            dynamic PostDataArrived = CS.GetPostData(this.Request);

            try
            {
                PasswordObj istatUser = new PasswordObj();
                istatUser.UserCode = (string)PostDataArrived.UserCode;
                istatUser.NewPassword = (string)PostDataArrived.NewPassword;
                istatUser.OldPassword = (string)PostDataArrived.OldPassword;


                SingleSignONService ssoService = new SingleSignONService();
                return CS.ReturnForJQuery(ssoService.ChangePassword(istatUser));
            }
            catch (Exception ex)
            {
                //return CS.ReturnForJQuery(ControllerSupport.ErrorOccured);
                return CS.ReturnForJQuery(ex.Message);
            }
        }


    }
}
