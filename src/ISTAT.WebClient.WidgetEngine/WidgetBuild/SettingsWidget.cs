using System;
using System.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web.Script.Serialization;

using log4net;

using ISTAT.WebClient.WidgetComplements.Model;
using ISTAT.WebClient.WidgetComplements.Model.Settings;
using ISTAT.WebClient.WidgetComplements.Model.JSObject;

namespace ISTAT.WebClient.WidgetEngine.WidgetBuild
{
    public class SettingsWidget
    {
        public SqlConnection Sqlconn { get; set; }
        private const string ErrorOccured = "{\"error\" : true }";
        private const string ErrorOccuredMess = "{\"error\" : true, \"message\" : {0} }";
        private static readonly ILog Logger = LogManager.GetLogger(typeof(QueryWidget));

        public SettingsWidget(string connectionString)
        {
            if (connectionString.ToLower() == "file")
            { Sqlconn = null; }
            else
            { Sqlconn = new SqlConnection(connectionString); }
        }

        public GetEndpointSettings Load()
        {
            GetEndpointSettings ret = null;
            if (Sqlconn != null)
            { //ret = LoadDB();
              ret = LoadWS();
            }
            else
            { ret = LoadFile(); }
            return ret;
        }

        public GetEndpointSettings LoadFile()
        {

            GetEndpointSettings ret = new GetEndpointSettings();
            ret.settings = new Settings();
            ret.settings.view_tree = true;
            ret.settings.view_tree_req = true;
            ret.settings.view_tree_select = true;
            ret.settings.view_login = false;

            EndpointSettings endpointSetting = new EndpointSettings();
            ret.endpoints = new List<EndpointSettings>();
            foreach (EndPointElement endPointEl in IRConfiguration.Config.EndPoints)
            {
                endpointSetting = new EndpointSettings();
                endpointSetting.Locale = endPointEl.Locale;
                endpointSetting.IDNode = endPointEl.IDNode;
                endpointSetting.Title = endPointEl.Title;
                endpointSetting.DecimalSeparator = endPointEl.DecimalSeparator;
                endpointSetting.Domain = endPointEl.Domain;
                endpointSetting.EnableHTTPAuthentication = endPointEl.EnableHTTPAuthentication;
                endpointSetting.EnableProxy = endPointEl.EnableProxy;
                endpointSetting.EndPoint = endPointEl.EndPoint;
                endpointSetting.EndPointV20 = endPointEl.EndPointV20;
                endpointSetting.EndPointType = endPointEl.EndPointType;
                endpointSetting.EndPointSource = endPointEl.EndPointSource;
                endpointSetting.Password = endPointEl.Password;
                endpointSetting.Prefix = endPointEl.Prefix;
                endpointSetting.ProxyPassword = endPointEl.ProxyPassword;
                endpointSetting.ProxyServer = endPointEl.ProxyServer;
                endpointSetting.ProxyServerPort = endPointEl.ProxyServerPort;
                endpointSetting.ProxyUserName = endPointEl.ProxyUserName;
                endpointSetting.UseSystemProxy = endPointEl.UseSystemProxy;
                endpointSetting.UserName = endPointEl.UserName;
                endpointSetting.Wsdl = endPointEl.Wsdl;
                endpointSetting.Active = endPointEl.Active;
                endpointSetting.UseUncategorysed = endPointEl.UseUncategorysed;
                endpointSetting.UseVirtualDf = endPointEl.UseVirtualDf;
                endpointSetting.Ordinamento = endPointEl.Ordinamento;
                //endpointSetting._TypeEndpoint = endPointEl._TypeEndpoint;
                //ret.endpoints.Add(new EndpointSettings(endpointSetting));
                ret.endpoints.Add(endpointSetting);
            }
            
            return ret;
        }
        public GetEndpointSettings LoadDB()
        //public GetEndpointSettings LoadDBMultiRow()
        {

            GetEndpointSettings ret = null;

            try
            {
                Sqlconn.Open();

                string sqlquery;

                sqlquery = string.Format(@"SELECT * FROM [Settings]");
                using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                {
                    IDataReader resAdd = comm.ExecuteReader();
                    if (resAdd.Read()) ret = (GetEndpointSettings)new JavaScriptSerializer().Deserialize(resAdd.GetString(resAdd.GetOrdinal("Setting")), typeof(GetEndpointSettings));
                }
            }
            catch (Exception ex)
            {
                Logger.Warn(ex.Message, ex);
                throw new Exception(string.Format(ErrorOccuredMess, ex.Message));
            }
            finally
            {
                Sqlconn.Close();
            }
            return ret;
        }


        public bool Save(GetEndpointSettings PostDataArrived)
        {
            bool success = false;
            try
            {
                if (PostDataArrived == null) throw new Exception("Input Error");

                Sqlconn.Open();

                string sqlquery;


                sqlquery = string.Format(@"INSERT INTO [Settings] ([Setting]) VALUES('{0}')", new JavaScriptSerializer().Serialize(PostDataArrived).Replace("'", "''"));
                using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                {
                    int resAdd = comm.ExecuteNonQuery();
                    if (resAdd == 0)
                    {
                        success = false;
                        throw new Exception("Setting not insert");
                    }
                }

                success = true;
            }
            catch (Exception ex)
            {
                Logger.Warn(ex.Message, ex);
                throw new Exception(string.Format(ErrorOccuredMess, ex.Message));
            }
            finally
            {
                Sqlconn.Close();
            }
            return success;
        }

        public bool UpdateSettingsOPT(GetEndpointSettings PostDataArrived)
        {
            bool success = false;
            try
            {
                if (PostDataArrived == null) throw new Exception("Input Error");
                
                Sqlconn.Open();                
                string sqlquery;


                sqlquery = string.Format(@"UPDATE [SettingsOPT] SET [View_tree]='{0}', [View_tree_req]='{1}',[View_tree_select]='{2}',[View_login]={3} WHERE [IdOPT]=1", 
                    PostDataArrived.settings.view_tree?1:0,PostDataArrived.settings.view_tree_req?1:0,PostDataArrived.settings.view_tree_select?1:0,
                    PostDataArrived.settings.view_login?1:0
                    );
                using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                {
                    int resAdd = comm.ExecuteNonQuery();
                    if (resAdd == 0)
                    {
                        success = false;
                        throw new Exception("Setting not update");
                    }
                }

                success = true;
            }
            catch (Exception ex)
            {
                Logger.Warn(ex.Message, ex);
                throw new Exception(string.Format(ErrorOccuredMess, ex.Message));
            }
            finally
            {
                Sqlconn.Close();
            }
            return success;
        }


        public bool SaveWS(GetEndpointSettings PostDataArrived)
        {
            bool success = false;
            try
            {
                if (PostDataArrived == null) throw new Exception("Input Error");
                Sqlconn.Open();

                foreach (EndpointSettings endpointSetting in PostDataArrived.endpoints)
                {
                    string sqlquery;
                    sqlquery = string.Format(@"UPDATE SettingsWS SET [Ordering]='{0}', [Active]='{1}' WHERE [SettingId]='{2}'", endpointSetting.Ordinamento,(endpointSetting.Active)?1:0, endpointSetting.SettingID);
                    using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                      {
                        int resAdd = comm.ExecuteNonQuery();
                        if (resAdd == 0)
                        {
                            success = false;
                            throw new Exception("Setting not update");
                        }
                      }
                }

                success = true;
            }
            catch (Exception ex)
            {
                Logger.Warn(ex.Message, ex);
                throw new Exception(string.Format(ErrorOccuredMess, ex.Message));
            }
            finally
            {
                Sqlconn.Close();
            }
            return success;
        }

        public GetEndpointSettings LoadWS()
        {

            GetEndpointSettings ret = new GetEndpointSettings();
            ret.settings = new Settings();
            ret.settings.view_tree = true;
            ret.settings.view_tree_req = true;
            ret.settings.view_tree_select = true;
            ret.settings.view_login = true;
            EndpointSettings endpointSetting = new EndpointSettings();
            ret.endpoints = new List<EndpointSettings>();

            try
            {
                Sqlconn.Open();

                string sqlquery = string.Format(@"SELECT * FROM [SettingsOPT]");
                using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                {
                    IDataReader resAdd = comm.ExecuteReader();
                    if (resAdd.Read()) 
                    {
                        ret.settings.view_tree = (resAdd["view_tree"].ToString() == "True") ? true : false;
                        ret.settings.view_tree_req = (resAdd["view_tree_req"].ToString() == "True") ? true : false;
                        ret.settings.view_tree_select = (resAdd["view_tree_select"].ToString() == "True") ? true : false;
                        ret.settings.view_login = (resAdd["view_login"].ToString() == "True") ? true : false;
                    }
                    resAdd.Close();
                }                

                sqlquery = string.Format(@"SELECT * FROM [SettingsWS] ORDER BY [Ordering],[SettingId]");

                DataTable dtres = new DataTable();
                using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(comm))
                    {
                        da.Fill(dtres);
                    }
                }


                foreach (DataRow query in dtres.Rows)
                {
                    endpointSetting = new EndpointSettings();
                    endpointSetting.Locale = query["Locale"].ToString();
                    endpointSetting.IDNode = query["IDNode"].ToString();
                    endpointSetting.Title = query["Title"].ToString();
                    endpointSetting.DecimalSeparator = query["DecimalSeparator"].ToString();
                    endpointSetting.Domain = query["Domain"].ToString();
                    endpointSetting.EnableHTTPAuthentication = (query["EnableHTTPAuthentication"].ToString() == "True") ? true : false;
                    endpointSetting.EnableProxy = (query["EnableProxy"].ToString() == "True") ? true : false;
                    endpointSetting.EndPoint = query["EndPoint"].ToString();
                    endpointSetting.EndPointV20 = query["EndPointV20"].ToString();
                    endpointSetting.EndPointType = query["EndPointType"].ToString();
                    endpointSetting.EndPointSource = query["EndPointSource"].ToString();
                    endpointSetting.Password = query["Password"].ToString();
                    endpointSetting.Prefix = query["Prefix"].ToString();
                    endpointSetting.ProxyPassword = query["ProxyPassword"].ToString();
                    endpointSetting.ProxyServer = query["ProxyServer"].ToString();
                    endpointSetting.ProxyServerPort = Convert.ToInt32(query["ProxyServerPort"].ToString());
                    endpointSetting.ProxyUserName = query["ProxyUserName"].ToString();
                    endpointSetting.UseSystemProxy = (query["UseSystemProxy"].ToString() == "True") ? true : false;
                    endpointSetting.UserName = query["UserName"].ToString();
                    endpointSetting.Wsdl = query["Wsdl"].ToString();
                    endpointSetting.Active = (query["Active"].ToString() == "True") ? true : false;
                    endpointSetting.UseUncategorysed = (query["UseUncategorysed"].ToString() == "1") ? true : false;
                    endpointSetting.UseVirtualDf = (query["UseVirtualDf"].ToString() == "1") ? true : false;
                    endpointSetting.Ordinamento = Convert.ToInt32(query["Ordering"].ToString());
                    endpointSetting.SettingID = Convert.ToInt32(query["SettingID"].ToString());
                    //ret.endpoints.Add(new EndpointSettings(endpointSetting));
                    ret.endpoints.Add(endpointSetting);

                }


            }
            catch (Exception ex)
            {
                Logger.Warn(ex.Message, ex);
                throw new Exception(string.Format(ErrorOccuredMess, ex.Message));
            }
            finally
            {
                Sqlconn.Close();
            }
            return ret;
        }

        
        public bool SaveSingleWS(EndpointSettings PostDataArrived)
        {
            bool success = false;
            try
            {
                if (PostDataArrived == null) throw new Exception("Input Error");

                Sqlconn.Open();

                string sqlquery;

                sqlquery = string.Format(@"DELETE FROM [SettingsWS] WHERE [SettingId]='{0}'", PostDataArrived.SettingID);
                using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                {
                    int resAdd = comm.ExecuteNonQuery();
                    
                }


                sqlquery = string.Format(@"INSERT INTO SettingsWS ([IDNode],[Title],[DecimalSeparator],[Domain],[EnableHTTPAuthentication],
	                        [EnableProxy],[EndPoint],[EndPointV20],[EndPointType],[EndPointSource],[Password],
	                        [Prefix],[ProxyPassword],[ProxyServer],[ProxyServerPort],[ProxyUserName],[UseSystemProxy],[UserName],
	                        [Wsdl],[Active],[UseUncategorysed],[UseVirtualDf],[Ordering])
                            VALUES('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}','{15}','{16}','{17}','{18}',
                                   '{19}','{20}','{21}','{22}')",
                            PostDataArrived.IDNode,
                            PostDataArrived.Title.Replace("'", "''"),
                            PostDataArrived.DecimalSeparator,
                            PostDataArrived.Domain,
                            (PostDataArrived.EnableHTTPAuthentication)?1:0,
                            (PostDataArrived.EnableProxy)?1:0,
                            PostDataArrived.EndPoint,
                            PostDataArrived.EndPointV20,
                            PostDataArrived.EndPointType,
                            PostDataArrived.EndPointSource,
                            PostDataArrived.Password,
                            PostDataArrived.Prefix,
                            PostDataArrived.ProxyPassword,
                            PostDataArrived.ProxyServer,
                            PostDataArrived.ProxyServerPort,
                            PostDataArrived.ProxyUserName,
                            (PostDataArrived.UseSystemProxy)?1:0,
                            PostDataArrived.UserName,
                            PostDataArrived.Wsdl,
                            (PostDataArrived.Active)?1:0,
                            (PostDataArrived.UseUncategorysed)?1:0,
                            (PostDataArrived.UseVirtualDf)?1:0,
                            PostDataArrived.Ordinamento
                            );

	

                using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                {
                    int resAdd = comm.ExecuteNonQuery();
                    if (resAdd == 0)
                    {
                        success = false;
                        throw new Exception("Setting not insert");
                    }
                }

                success=true;
            }
            catch (Exception ex)
            {
                Logger.Warn(ex.Message, ex);
                throw new Exception(string.Format(ErrorOccuredMess, ex.Message));
            }
            finally
            {
                Sqlconn.Close();
            }
            return success;
        }


        public bool UpdateSingleWS(EndpointSettings PostDataArrived)
        {
            bool success = false;
            try
            {
                if (PostDataArrived == null) throw new Exception("Input Error");

                Sqlconn.Open();

                string sqlquery;

                sqlquery = string.Format(@"UPDATE SettingsWS SET [IDNode]='{0}', [Title]='{1}',[DecimalSeparator]='{2}',[Domain]='{3}',[EnableHTTPAuthentication]='{4}',
	                        [EnableProxy]='{5}',[EndPoint]='{6}',[EndPointV20]='{7}',[EndPointType]='{8}',[EndPointSource]='{9}',[Password]='{10}',
	                        [Prefix]='{11}',[ProxyPassword]='{12}',[ProxyServer]='{13}',[ProxyServerPort]='{14}',[ProxyUserName]='{15}',[UseSystemProxy]='{16}',
                            [UserName]='{17}',[Wsdl]='{18}',[Active]='{19}',[UseUncategorysed]='{20}',[UseVirtualDf]='{21}',[Ordering]='{22}' 
                            WHERE [SettingId]='{23}'",
            PostDataArrived.IDNode,
                    PostDataArrived.Title.Replace("'", "''"),
            //PostDataArrived.Title,
            PostDataArrived.DecimalSeparator,
            PostDataArrived.Domain,
            (PostDataArrived.EnableHTTPAuthentication) ? 1 : 0,
            (PostDataArrived.EnableProxy) ? 1 : 0,
            PostDataArrived.EndPoint,
            PostDataArrived.EndPointV20,
            PostDataArrived.EndPointType,
            PostDataArrived.EndPointSource,
            PostDataArrived.Password,
            PostDataArrived.Prefix,
            PostDataArrived.ProxyPassword,
            PostDataArrived.ProxyServer,
            PostDataArrived.ProxyServerPort,
            PostDataArrived.ProxyUserName,
            (PostDataArrived.UseSystemProxy) ? 1 : 0,
            PostDataArrived.UserName,
            PostDataArrived.Wsdl,
            (PostDataArrived.Active) ? 1 : 0,
            (PostDataArrived.UseUncategorysed) ? 1 : 0,
            (PostDataArrived.UseVirtualDf) ? 1 : 0,
            PostDataArrived.Ordinamento,
            PostDataArrived.SettingID
            );
                using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                {
                    int resAdd = comm.ExecuteNonQuery();

                }

                success = true;
            }
            catch (Exception ex)
            {
                Logger.Warn(ex.Message, ex);
                throw new Exception(string.Format(ErrorOccuredMess, ex.Message));
            }
            finally
            {
                Sqlconn.Close();
            }
            return success;
        }


        public bool DeleteSingleWS(EndpointSettings PostDataArrived)
        {
            bool success = false;
            try
            {
                if (PostDataArrived == null) throw new Exception("Input Error");

                Sqlconn.Open();

                string sqlquery;

                sqlquery = string.Format(@"DELETE FROM [SettingsWS] WHERE [SettingId]='{0}'", PostDataArrived.SettingID);
                using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                {
                    int resAdd = comm.ExecuteNonQuery();

                }

                success = true;
            }
            catch (Exception ex)
            {
                Logger.Warn(ex.Message, ex);
                throw new Exception(string.Format(ErrorOccuredMess, ex.Message));
            }
            finally
            {
                Sqlconn.Close();
            }
            return success;
        }


        public UserSettingResponseObject LoadUserSetting(string userCode)
        {
            UserSettingResponseObject ret = null;
            
            if (Sqlconn != null)
            { ret = LoadUserSettingDB(userCode); }
            else
            { ret = LoadUserSettingFile(userCode); }
            
            return ret;
        }

        public UserSettingResponseObject LoadUserSettingFile(string userCode)
        {

               UserSettingResponseObject ret = new UserSettingResponseObject();
               if (ConfigurationManager.AppSettings["main_fontFamily"]!=null)
               { ret.main_fontFamily = ConfigurationManager.AppSettings["main_fontFamily"].ToString(); }
               else
               { ret.main_fontFamily = "Arial"; }

               if (ConfigurationManager.AppSettings["main_fontSize"] != null)
               { ret.main_fontSize = ConfigurationManager.AppSettings["main_fontSize"].ToString(); }
               else
               { ret.main_fontSize = "12"; }

               if (ConfigurationManager.AppSettings["main_containerWidth"] != null)
               { ret.main_containerWidth = ConfigurationManager.AppSettings["main_containerWidth"].ToString(); }
               else
               { ret.main_containerWidth = "100%"; }

               if (ConfigurationManager.AppSettings["main_css"] != null)
               { ret.main_css = ConfigurationManager.AppSettings["main_css"].ToString(); }
               else
               { ret.main_css = "Content/style/custom/sistan.css"; }

            return ret;
        }
 
        public UserSettingResponseObject LoadUserSettingDB(string userCode) {

            UserSettingResponseObject ret = null;

            try
            {
                Sqlconn.Open();

                string sqlquery;

                sqlquery = string.Format(@"SELECT * FROM [UserSettings] WHERE [UserCode]='" + userCode + "'");
                using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                {
                    using (IDataReader resAdd = comm.ExecuteReader())
                    {
                        if (resAdd.Read())
                        {
                            ret = (UserSettingResponseObject)new JavaScriptSerializer().Deserialize(resAdd.GetString(resAdd.GetOrdinal("Settings")), typeof(UserSettingResponseObject));
                        }
                    }
                }
                if (ret == null) {
                    sqlquery = string.Format(@"SELECT * FROM [UserSettings] WHERE [UserCode]='DEFAULT_SETT'");
                    using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                    {
                        using (IDataReader resAdd = comm.ExecuteReader())
                        {
                            if (resAdd.Read())
                            {
                                ret = (UserSettingResponseObject)new JavaScriptSerializer().Deserialize(resAdd.GetString(resAdd.GetOrdinal("Settings")), typeof(UserSettingResponseObject));
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.Warn(ex.Message, ex);
                throw new Exception(string.Format(ErrorOccuredMess, ex.Message));
            }
            finally
            {
                Sqlconn.Close();
            }
            return ret;
        }
        public bool SaveUserSetting(GetUserSettingObject PostDataArrived)
        {
            bool success = false;
            try
            {
                if (PostDataArrived == null) throw new Exception("Input Error");

                Sqlconn.Open();

                string sqlquery;
                sqlquery = string.Format(@"DELETE FROM [UserSettings] WHERE [UserCode]='" + PostDataArrived.userCode + "'");
                using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                {
                    int resAdd = comm.ExecuteNonQuery();
                }

                sqlquery = string.Format(@"INSERT INTO [UserSettings] ([UserCode],[Settings]) VALUES('{0}','{1}')",PostDataArrived.userCode, new JavaScriptSerializer().Serialize(PostDataArrived.setting).Replace("'", "''"));
                using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                {
                    int resAdd = comm.ExecuteNonQuery();
                    if (resAdd == 0)
                    {
                        success = false;
                        throw new Exception("User Setting not insert");
                    }
                }
                success = true;


            }
            catch (Exception ex)
            {
                Logger.Warn(ex.Message, ex);
                throw new Exception(string.Format(ErrorOccuredMess, ex.Message));
            }
            finally
            {
                Sqlconn.Close();

                if (PostDataArrived.userRole == 1)
                {
                    success = SaveDefaultSetting(PostDataArrived);
                }
            }
            return success;
        }

        public bool SaveDefaultSetting(GetUserSettingObject PostDataArrived)
        {
            bool success = false;
            try
            {
                if (PostDataArrived == null) throw new Exception("Input Error");

                Sqlconn.Open();

                string sqlquery;
                sqlquery = string.Format(@"DELETE FROM [UserSettings] WHERE [UserCode]='DEFAULT_SETT'");
                using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                {
                    int resAdd = comm.ExecuteNonQuery();
                }

                sqlquery = string.Format(@"INSERT INTO [UserSettings] ([UserCode],[Settings]) VALUES('DEFAULT_SETT','{0}')", new JavaScriptSerializer().Serialize(PostDataArrived.setting).Replace("'", "''"));
                using (SqlCommand comm = new SqlCommand(sqlquery, Sqlconn))
                {
                    int resAdd = comm.ExecuteNonQuery();
                    if (resAdd == 0)
                    {
                        success = false;
                        throw new Exception("User Setting not insert");
                    }
                }
                success = true;
            }
            catch (Exception ex)
            {
                Logger.Warn(ex.Message, ex);
                throw new Exception(string.Format(ErrorOccuredMess, ex.Message));
            }
            finally
            {
                Sqlconn.Close();
            }
            return success;
        }

    }
}
