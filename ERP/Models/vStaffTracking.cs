//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ERP.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class vStaffTracking
    {
        public int id_employee { get; set; }
        public string lastname { get; set; }
        public string name { get; set; }
        public int age { get; set; }
        public string email { get; set; }
        public string phone { get; set; }
        public string address { get; set; }
        public string module { get; set; }
        public string position { get; set; }
        public string pay { get; set; }
        public string result { get; set; }
        public string work_days { get; set; }
        public int work_hours { get; set; }
        public int remaining_holidays { get; set; }
        public int paid_holidays { get; set; }
    }
}