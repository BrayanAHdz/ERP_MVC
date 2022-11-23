using ERP.Models;
using ERP.Tools;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;

namespace ERP.Controllers
{
    public class AccessController : Controller
    {
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string Us, string Pass)
        {
            try
            {
                using (ERPEntities db = new ERPEntities())
                {
                    string pass = Encrypt.GetSHA256(Pass.Trim());
                    var user = (from d in db.User
                                where d.username == Us.Trim() && d.password == pass
                                select d).FirstOrDefault();
                    if (user == null) 
                    {
                        ViewBag.Error = "Usuario o contraseña invalidos";
                        return View();
                    }

                    Session["User"] = user;
                    Session["Username"] = Us;
                }
                
                return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                ViewBag.Error = string.Format("Error: {0}", ex);
                return View();
            }
        }

        public ActionResult ColseSession()
        {
            try
            {
                Session["User"] = null;

                return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                ViewBag.Error = string.Format("Error: {0}", ex);
                return View();
            }
        }
    }
}
