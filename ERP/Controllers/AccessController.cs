using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
                using (Models.ERPEntities db = new Models.ERPEntities())
                {
                    var user = (from d in db.User
                                where d.username == Us.Trim() && d.password == Pass.Trim()
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
            catch
            {
                return View();
            }
        }
    }
}
