﻿using ISTAT.SingleSignON.Service.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Runtime.Serialization;
using System.Text;

namespace ISTAT.SingleSignON.Service
{
    public class SingleSignONService : ISingleSignONService
    {
        public SingleSignONService()
        {
            Configuration config = new Configuration();
        }


        public ISTATUser Login(LoginObj login)
        {
            try
            {
                ISTAT.SingleSignON.Service.Model.DBUserEntities cnn = new ISTAT.SingleSignON.Service.Model.DBUserEntities();
                if (string.IsNullOrEmpty(login.Email) || string.IsNullOrEmpty(login.Password))
                    throw new Exception("Insert Email or Password");


                string PassCript = Utils.CriptaPassword(login.Password.Trim());
                User newut = cnn.Users.FirstOrDefault(u => u.Email.Trim() == login.Email.Trim() && u.Password.Trim() == PassCript);
                if (newut == null)
                    throw new Exception("User not found, Mail or Password is Invalid");
                return Utils.ConvertISTATUser(newut);
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Login Failed: {0}", ex));
            }
        }

        public List<ISTATUser> GetUsers()
        {
            try
            {
                ISTAT.SingleSignON.Service.Model.DBUserEntities cnn = new ISTAT.SingleSignON.Service.Model.DBUserEntities();

                var utenti = (from user in cnn.Users
                              select user);

                List<ISTATUser> utentiIstat = new List<ISTATUser>();
                if (utenti != null)
                    utenti.ToList().ForEach(u => utentiIstat.Add(Utils.ConvertISTATUser(u)));

                return utentiIstat;
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Get Users Error: {0}", ex));
            }
        }

        public ISTATUser GetUser(string UserCode)
        {
            try
            {
                ISTAT.SingleSignON.Service.Model.DBUserEntities cnn = new ISTAT.SingleSignON.Service.Model.DBUserEntities();

                var utenti = (from user in cnn.Users
                              where user.UserCode == UserCode
                              select user);
                if (utenti != null && utenti.Count() == 1)
                {
                    return Utils.ConvertISTATUser(utenti.First());
                }
                throw new Exception(string.Format("No User Found"));
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Get Users Error: {0}", ex));
            }
        }

        public ISTATUser AddUser(ISTATUser user)
        {
            try
            {
                ISTAT.SingleSignON.Service.Model.DBUserEntities cnn = new ISTAT.SingleSignON.Service.Model.DBUserEntities();
                user = ValidNullField(user);
                //Controlla Password
                if (!Utils.ValidatePassword(user.Password))
                    throw new Exception("Error Format Password");
                //Controllo stessa mail
                if (cnn.Users.Count(u => u.Email.Trim() == user.Email.Trim()) > 0)
                    throw new Exception("Already exist user with this E-mail");

                User newut = new User()
                {
                    UserCode = Guid.NewGuid().ToString(),
                    Email = user.Email == null ? null : user.Email.Trim(),
                    Name = user.Name == null ? null : user.Name.Trim(),
                    Surname = user.Surname == null ? null : user.Surname.Trim(),
                    Sex = user.Sex == null ? null : user.Sex.Trim(),
                    Age = user.Age == null ? null : user.Age.Trim(),
                    Country = user.Country == null ? null : user.Country.Trim(),
                    Study = user.Study == null ? null : user.Study.Trim(),
                    Position = user.Position == null ? null : user.Position.Trim(),
                    Agency = user.Agency == null ? null : user.Agency.Trim(),
                    Lang = user.Lang == null ? null : user.Lang.Trim(),
                };
                List<UserPreference> up = new List<UserPreference>();
                if (user.Themes != null)
                    user.Themes.ForEach(p => up.Add(new UserPreference() { UserCode = newut.UserCode, PreferenceCode = p.Trim() }));

                newut.UserPreferences = up;
                newut.Password = Utils.CriptaPassword(user.Password.Trim());

                cnn.Users.Add(newut);
                var errors = cnn.GetValidationErrors();
                if (errors != null && errors.Count(e => !e.IsValid) > 0)
                    throw new Exception(string.Format("Add User Error: {0}", errors.FirstOrDefault(e => !e.IsValid).ValidationErrors.FirstOrDefault().ErrorMessage));

                int ris = cnn.SaveChanges();
                if (ris > 0)
                {
                    return Utils.ConvertISTATUser(newut);
                }
                else
                    throw new Exception("Add User Error");
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Add User Error: {0}", ex));
            }

        }


        public ISTATUser ModUser(ISTATUser user)
        {
            try
            {
                ISTAT.SingleSignON.Service.Model.DBUserEntities cnn = new ISTAT.SingleSignON.Service.Model.DBUserEntities();
                user = ValidNullField(user);
                User newut = cnn.Users.FirstOrDefault(u => user.UserCode != null && u.UserCode.Trim() == user.UserCode.Trim());
                if (newut == null)
                    throw new Exception("User to chenge not found");

                if (newut.Email.Trim() != user.Email.Trim())
                {
                    //Controllo stessa mail
                    if (cnn.Users.Count(u => u.Email.Trim() == user.Email.Trim()) > 0)
                        throw new Exception("Already exist user with this E-mail");
                }
                newut.Email = user.Email == null ? null : user.Email.Trim();
                newut.Name = user.Name == null ? null : user.Name.Trim();
                newut.Surname = user.Surname == null ? null : user.Surname.Trim();
                newut.Sex = user.Sex == null ? null : user.Sex.Trim();
                newut.Age = user.Age == null ? null : user.Age.Trim();
                newut.Country = user.Country == null ? null : user.Country.Trim();
                newut.Study = user.Study == null ? null : user.Study.Trim();
                newut.Position = user.Position == null ? null : user.Position.Trim();
                newut.Agency = user.Agency == null ? null : user.Agency.Trim();
                newut.Lang = user.Lang == null ? null : user.Lang.Trim();
                List<UserPreference> up = new List<UserPreference>();
                if (newut.UserPreferences != null && newut.UserPreferences.Count > 0)
                {
                    (from userpreference in cnn.UserPreferences
                     where userpreference.UserCode == newut.UserCode
                     select userpreference).ToList().ForEach(userpreference => cnn.UserPreferences.Remove(userpreference));
                    newut.UserPreferences.Clear();
                }
                if (user.Themes != null)
                    user.Themes.ForEach(p => up.Add(new UserPreference() { UserCode = newut.UserCode, PreferenceCode = p.Trim() }));

                newut.UserPreferences = up;


                var errors = cnn.GetValidationErrors();
                if (errors != null && errors.Count(e => !e.IsValid) > 0)
                    throw new Exception(string.Format("Change User Error: {0}", errors.FirstOrDefault(e => !e.IsValid).ValidationErrors.FirstOrDefault().ErrorMessage));
                int ris = cnn.SaveChanges();
                return Utils.ConvertISTATUser(newut);
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Modify User Error: {0}", ex));
            }
        }

        public bool DelUser(ISTATUser user)
        {
            try
            {

                ISTAT.SingleSignON.Service.Model.DBUserEntities cnn = new ISTAT.SingleSignON.Service.Model.DBUserEntities();
                User newut = cnn.Users.FirstOrDefault(u => user.UserCode != null && u.UserCode.Trim() == user.UserCode.Trim());
                if (newut == null)
                    throw new Exception("User to delete not found");
                if (newut.UserPreferences != null && newut.UserPreferences.Count > 0)
                {
                    (from userpreference in cnn.UserPreferences
                     where userpreference.UserCode == newut.UserCode
                     select userpreference).ToList().ForEach(userpreference => cnn.UserPreferences.Remove(userpreference));
                    newut.UserPreferences.Clear();
                }
                cnn.Users.Remove(newut);
                var errors = cnn.GetValidationErrors();
                if (errors != null && errors.Count(e => !e.IsValid) > 0)
                    throw new Exception(string.Format("Delete User Error: {0}", errors.FirstOrDefault(e => !e.IsValid).ValidationErrors.FirstOrDefault().ErrorMessage));
                int ris = cnn.SaveChanges();
                return (ris > 0);

            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Delete User Error: {0}", ex));
            }
        }

        public Dictionary<string, List<MetadataObject>> GetMetadata(string Lang)
        {
            try
            {
                ISTAT.SingleSignON.Service.Model.DBUserEntities cnn = new ISTAT.SingleSignON.Service.Model.DBUserEntities();
                Dictionary<string, List<MetadataObject>> metadatas = new Dictionary<string, List<MetadataObject>>();

                (from metadata in cnn.Localisations
                 where metadata.Lang.Trim().ToLower() == Lang.Trim().ToLower()
                 select metadata).ToList().ForEach(m =>
                 {
                     if (!metadatas.ContainsKey(m.TableName.Trim()))
                         metadatas[m.TableName.Trim()] = new List<MetadataObject>();
                     metadatas[m.TableName.Trim()].Add(new MetadataObject()
                     {
                         Code = m.Code.Trim(),
                         Description = m.Description.Trim()
                     });

                 });
                return metadatas;
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Retreive Metadatas Error: {0}", ex));
            }
        }





        public bool ChangePassword(PasswordObj passobj)
        {
            try
            {
                ISTAT.SingleSignON.Service.Model.DBUserEntities cnn = new ISTAT.SingleSignON.Service.Model.DBUserEntities();
                if (string.IsNullOrEmpty(passobj.UserCode) || string.IsNullOrEmpty(passobj.OldPassword))
                    throw new Exception("UserCode or Old Password Invalid");
                string PassCript = Utils.CriptaPassword(passobj.OldPassword.Trim());
                User newut = cnn.Users.FirstOrDefault(u => u.UserCode.Trim() == passobj.UserCode.Trim() && u.Password.Trim() == PassCript);
                if (newut == null)
                    throw new Exception("User not found");

                //Controlla Password
                if (!Utils.ValidatePassword(passobj.NewPassword))
                    throw new Exception("Error Format Password");
                newut.Password = Utils.CriptaPassword(passobj.NewPassword.Trim());

                var errors = cnn.GetValidationErrors();
                if (errors != null && errors.Count(e => !e.IsValid) > 0)
                    throw new Exception(string.Format("Change Password Error: {0}", errors.FirstOrDefault(e => !e.IsValid).ValidationErrors.FirstOrDefault().ErrorMessage));
                int ris = cnn.SaveChanges();
                return (ris > 0);

            }

            catch (Exception ex)
            {
                throw new Exception(string.Format("Change Password Error: {0}", ex));
            }
        }

        public bool ResetPassword(MailObject Mailobj)
        {
            try
            {
                ISTAT.SingleSignON.Service.Model.DBUserEntities cnn = new ISTAT.SingleSignON.Service.Model.DBUserEntities();
                User newut = cnn.Users.FirstOrDefault(u => Mailobj.EmailUser != null && u.Email.Trim() == Mailobj.EmailUser.Trim());
                if (newut == null)
                    throw new Exception("User not found");

                string OLDPass = newut.Password;
                //Genera nuova password

                string newPass = Utils.RandomPassword();


                //Salva Nuova Password
                newut.Password = Utils.CriptaPassword(newPass);

                var errors = cnn.GetValidationErrors();
                if (errors != null && errors.Count(e => !e.IsValid) > 0)
                    throw new Exception(string.Format("Change Password Error: {0}", errors.FirstOrDefault(e => !e.IsValid).ValidationErrors.FirstOrDefault().ErrorMessage));
                int ris = cnn.SaveChanges();
                try
                { //InviaMail
                    Mailobj.MailTemplate = Mailobj.MailTemplate.Replace("##NEWPASSWORD##", newPass);
                    Utils.SendMail(newut.Email, Mailobj);
                }
                catch (Exception ex)
                {
                    newut.Password = OLDPass;
                    errors = cnn.GetValidationErrors();
                    if (errors != null && errors.Count(e => !e.IsValid) > 0)
                        throw new Exception(string.Format("Change Password Error: {0}", errors.FirstOrDefault(e => !e.IsValid).ValidationErrors.FirstOrDefault().ErrorMessage));
                    ris = cnn.SaveChanges();
                    throw new Exception(string.Format("SendMail error: {0}", ex.Message));

                }

                return (ris > 0);
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Change Password Error: {0}", ex));
            }
        }

        #region Private Method
        private ISTATUser ValidNullField(ISTATUser user)
        {
            if (user.UserCode != null && string.IsNullOrEmpty(user.UserCode.Trim()))
                user.UserCode = null;
            if (user.Name != null && string.IsNullOrEmpty(user.Name.Trim()))
                user.Name = null;
            if (user.Surname != null && string.IsNullOrEmpty(user.Surname.Trim()))
                user.Surname = null;
            if (user.Email != null && string.IsNullOrEmpty(user.Email.Trim()))
                user.Email = null;
            if (user.Password != null && string.IsNullOrEmpty(user.Password.Trim()))
                user.Password = null;

            if (user.Age != null && string.IsNullOrEmpty(user.Age.Trim()))
                user.Age = null;
            if (user.Agency != null && string.IsNullOrEmpty(user.Agency.Trim()))
                user.Agency = null;
            if (user.Country != null && string.IsNullOrEmpty(user.Country.Trim()))
                user.Country = null;
            if (user.Position != null && string.IsNullOrEmpty(user.Position.Trim()))
                user.Position = null;
            if (user.Sex != null && string.IsNullOrEmpty(user.Sex.Trim()))
                user.Sex = null;
            if (user.Study != null && string.IsNullOrEmpty(user.Study.Trim()))
                user.Study = null;
            if (user.Lang != null && string.IsNullOrEmpty(user.Lang.Trim()))
                user.Lang = null;

            return user;
        }
        #endregion
    }

}
