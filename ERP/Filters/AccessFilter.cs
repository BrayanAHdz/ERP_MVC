using ERP.Controllers;
using ERP.Models;
using System;
using System.Web;
using System.Web.Mvc;

namespace ERP.Filters
{
    public class AccessFilter : ActionFilterAttribute
    {
        private User user;
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            try 
            {
                base.OnActionExecuting(filterContext);
                user = (User)HttpContext.Current.Session["User"];
                if (user == null)
                {
                    if(filterContext.Controller is AccessController == false && filterContext.Controller is PrinterController == false)
                    {
                        filterContext.HttpContext.Response.Redirect("/Access/Login");
                    }
                }
            }
            catch (Exception)
            {
                filterContext.Result = new RedirectResult("~/Access/Login");
            }
        }
    }
}