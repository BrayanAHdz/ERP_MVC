using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;

namespace ERP.Controllers
{
    public class AccessController : Controller
    {
        private string username;
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string Us, string Pass)
        {
            try
            {
                using (Models.ERPEntities1 db = new Models.ERPEntities1())
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
                    username = Us;
                }
                
                return RedirectToAction("Index", "Home");
            }
            catch
            {
                return View();
            }
        }

        public string getUsername()
        {
            return username;
        }
    }
}
