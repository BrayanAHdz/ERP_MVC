using ERP.Models;
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
                using (ERPEntities1 db = new ERPEntities1())
                {
                    string pass = GetSHA256(Pass.Trim());
                    var user = (from d in db.User
                                where d.username == Us.Trim() && d.password == pass
                                select d).FirstOrDefault();
                    if (user == null) 
                    {
                        ViewBag.Error = "Usuario o contraseña invalidos";
                        return View();
                    }

                    Session["User"] = user;
                }
                
                return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                ViewBag.Error = string.Format("Error: {0}", ex);
                return View();
            }
        }
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(string Us, string Pass, int Rol_Id)
        {
            if (Us.IsNullOrWhiteSpace() || Pass.IsNullOrWhiteSpace())
            {
                ViewBag.Error = "Usuario o contraseña no validos";
                return View();
            }
            try
            {
                using (ERPEntities1 db = new ERPEntities1()) {
                    User oUser = new User();
                    oUser.username = Us.Trim();
                    oUser.password = GetSHA256(Pass.Trim());
                    oUser.id_rol= Rol_Id;
                    db.User.Add(oUser);
                    db.SaveChanges();
                }
                ViewBag.Success = "Usuario agregado correctamente";
                return View();
            }
            catch (DbEntityValidationException e)
            {
                foreach (var eve in e.EntityValidationErrors)
                {
                    ViewBag.Error = string.Format("Entity of type \"{0}\" in state \"{1}\" has the following validation errors:",
                        eve.Entry.Entity.GetType().Name, eve.Entry.State);
                    foreach (var ve in eve.ValidationErrors)
                    {
                        ViewBag.Error = ViewBag.Error + string.Format("- Property: \"{0}\", Error: \"{1}\"",
                            ve.PropertyName, ve.ErrorMessage);
                    }
                }
                return View();
            }
        }
        public static string GetSHA256(string str)
        {
            SHA256 sha256 = SHA256.Create();
            ASCIIEncoding encoding = new ASCIIEncoding();
            byte[] stream = null;
            StringBuilder sb = new StringBuilder();
            stream = sha256.ComputeHash(encoding.GetBytes(str));
            for (int i = 0; i < stream.Length; i++) sb.AppendFormat("{0:x2}", stream[i]);
            return sb.ToString();
        }
    }
}
