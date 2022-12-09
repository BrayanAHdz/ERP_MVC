using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP.Controllers
{
    public class ErrorController : Controller
    {
        public ActionResult PageNotFound()
        {
            return View();
        }
        public ActionResult UnAuthorizedUser()
        {
            return View();
        }
    }
}
