using ERP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ERP.Filters;

namespace ERP.Controllers
{
    public class ReportsController : Controller
    {
        private static int page;
        private static string search;
        
        [AuthorizeUser(1)]
        public ActionResult Reports()
        {
            return View();
        }
        [AuthorizeUser(1)]
        public ActionResult Evaluations()
        {
            search = "";
            page = 0;
            return View(Search.AllEvaluations(search, page));
        }

        [HttpPost]
        public ActionResult Evaluations(string oSearch)
        {
            ViewBag.Volver = "Volver";
            search = oSearch;
            page = 0;
            return View(Search.AllEvaluations(search, page));
        }

        [AuthorizeUser(1)]
        public ActionResult Employee()
        {
            search = "";
            page = 0;
            return View(Search.Employees(search, page));
        }

        [HttpPost]
        public ActionResult Employee(string oSearch)
        {
            ViewBag.Volver = "Volver";
            search = oSearch;
            page = 0;
            return View(Search.Employees(search, page));
        }
        [AuthorizeUser(1)]
        public ActionResult NextEvaluation()
        {
            next();
            return View("Evaluations", Search.AllEvaluations(search, page));
        }
        [AuthorizeUser(1)]
        public ActionResult PrevEvaluation()
        {
            prev();
            return View("Evaluations", Search.AllEvaluations(search, page));
        }

        [AuthorizeUser(1)]
        public ActionResult NextEmployee()
        {
            next();
            return View("Employee", Search.Employees(search, page));
        }
        [AuthorizeUser(1)]
        public ActionResult PrevEmployee()
        {
            prev();
            return View("Employee", Search.Employees(search, page));
        }

        private void next()
        {
            ViewBag.Volver = "Volver";
            ViewBag.Prev = "Anterior";
            page++;
        }
        private void prev()
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
        }
    }
}
