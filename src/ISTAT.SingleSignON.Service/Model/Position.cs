//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ISTAT.SingleSignON.Service.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class Position
    {
        public Position()
        {
            this.Users = new HashSet<User>();
        }
    
        public string PositionCode { get; set; }
    
        public virtual ICollection<User> Users { get; set; }
    }
}