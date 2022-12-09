using ERP.Models;
using Rotativa;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ERP.Controllers
{
    public class PrinterController : Controller
    {
        public ActionResult EvaluationReport()
        {
            Evaluation oEvaluation;
            using (ERPEntities db = new ERPEntities())
            {
                oEvaluation = (from d in db.Evaluation
                               select d).OrderByDescending(d => d.id_evaluation).FirstOrDefault();
            }
            return View(oEvaluation);
        }
        public ActionResult EmployeeReport(int id)
        {
            return View(Search.StaffTrackings(id));
        }

        public ActionResult PrintLastEvaluationReport()
        {
            return new ActionAsPdf("EvaluationReport") { FileName = "ReporteEvaluación" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".pdf" };
        }
        public ActionResult SelectedEvaluationReport(int id)
        {
            return View("EvaluationReport", Search.GetEvaluation(id));
        }

        public ActionResult PrintEvaluationReport(int id)
        {
            return new ActionAsPdf("SelectedEvaluationReport", new { id }) { FileName = "ReporteEvaluación" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".pdf" };
        }

        public ActionResult PrintEmployeeReport(int id)
        {
            return new ActionAsPdf("EmployeeReport", new { id }) { FileName = "ReporteEmpleado" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".pdf" };
        }
    }
}