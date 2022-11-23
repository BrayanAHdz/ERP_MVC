using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP.Controllers
{
    public class EmployeeController : Controller
    {
        public ActionResult NewEvaluation()
        {
            ViewBag.Message = Session["Username"] as string;
            return View();
        }
        public ActionResult NewEmployee()
        {
            ViewBag.Message = Session["Username"] as string;
            return View();
        }

        public ActionResult StaffTracking()
        {
            ViewBag.Message = Session["Username"] as string;
            return View();
        }

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
