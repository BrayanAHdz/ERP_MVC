using ERP.Filters;
using ERP.Models;
using ERP.Tools;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace ERP.Controllers
{
    public class UsersController : Controller
    {
        private static int page;
        private static string search;

        [AuthorizeUser(2)]
        public ActionResult Users()
        {
            search= "";
            page= 0;
            return View(Search.Users(search, page));
        }

        [HttpPost]
        public ActionResult Users(string oSearch)
        {
            ViewBag.Volver = "Volver";
            search = oSearch;
            page = 0;
            return View(Search.Users(search, page));
        }

        [AuthorizeUser(2)]
        public ActionResult EditUser(int id)
        {
            using (ERPEntities db = new ERPEntities())
            {
                User oUser = db.User.Find(id);
                return View(oUser);
            }
        }
        [HttpPost]
        public ActionResult EditUser(int Id, string Us, string Pass, int Rol_Id)
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
                    User oUser = db.User.Find(Id);
                    oUser.username = Us.Trim();
                    oUser.password = Encrypt.GetSHA256(Pass.Trim());
                    oUser.id_rol = Rol_Id;
                    db.Entry(oUser).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                }
                ViewBag.Success = "Hola";
                return RedirectToAction("Users", "Users");
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

        [HttpPost]
        public ActionResult DeleteUser(int id)
        {
            if(id == int.Parse(Session["IdUser"] as string)) return Content("2");
            using (ERPEntities db = new ERPEntities()) 
            {
                User oUser = db.User.Find(id);
                oUser.state = 1;
                db.Entry(oUser).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
            }

            return Content("1");
        }

        [AuthorizeUser(2)]
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

        [AuthorizeUser(2)]
        public ActionResult NextUsers()
        {
            ViewBag.Volver = "Volver";
            ViewBag.Prev = "Anterior";
            page++;
            return View("User", Search.Users(search, page));
        }

        [AuthorizeUser(2)]
        public ActionResult PrevUsers()
        {
            if (page > 0)
            {
                page--;
                if (page != 0)
                {
                    ViewBag.Volver = "Volver";
                    ViewBag.Prev = "Anterior";
                }
            }
            return View("User", Search.Users(search, page));
        }
    }
}
