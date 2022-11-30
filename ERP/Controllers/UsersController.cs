using ERP.Models;
using ERP.Tools;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP.Controllers
{
    public class UsersController : Controller
    {
        public ActionResult Register()
        {
            ViewBag.Message = Session["Username"] as string;
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
                using (ERPEntities db = new ERPEntities())
                {
                    User oUser = new User();
                    oUser.username = Us.Trim();
                    oUser.password = Encrypt.GetSHA256(Pass.Trim());
                    oUser.id_rol = Rol_Id;
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
    }
}
