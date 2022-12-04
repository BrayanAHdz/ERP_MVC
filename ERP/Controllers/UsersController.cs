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
        public ActionResult Users()
        {
            ViewBag.Message = Session["Username"] as string;
            List<User> list = new List<User>();
            using (ERPEntities db = new ERPEntities())
            {
                list = (from d in db.User
                        where d.state == 0
                        select d).ToList();
            }
            return View(list);
        }

        [HttpPost]
        public ActionResult Users(string Search)
        {
            ViewBag.Message = Session["Username"] as string;
            ViewBag.Volver = "Volver";
            List<User> list = new List<User>();
            using (ERPEntities db = new ERPEntities())
            {
                list = (from d in db.User
                        where d.username.Contains(Search) && d.state == 0
                        select d).ToList();
            }
            return View(list);
        }

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
