using ERP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP.Filters
{
    [AttributeUsage(AttributeTargets.Method, AllowMultiple = false)]
    public class AuthorizeUser : AuthorizeAttribute
    {
        private User oUser;
        private int id_op;
        private ERPEntities db = new ERPEntities();

        public AuthorizeUser(int idOp) 
        {
            id_op = idOp;
        }

        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            try {
                oUser = (User)HttpContext.Current.Session["User"];
                if(oUser == null) filterContext.HttpContext.Response.Redirect("~/Access/Login");

                var lstOp = (from d in db.Rol_Operation
                             where d.id_rol == oUser.id_rol && d.id_operation == id_op
                             select d).ToList().Count;

                if (lstOp < 1)
                {
                    filterContext.HttpContext.Response.Redirect("~/Error/UnAuthorizedUser");
                }
            }
            catch(Exception ex) 
            {
                filterContext.HttpContext.Response.Redirect("~/Error/UnAuthorizedUser");
            }
        }
    }
}