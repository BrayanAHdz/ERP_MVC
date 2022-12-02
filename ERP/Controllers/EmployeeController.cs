using ERP.Models;
using ERP.Tools;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;

namespace ERP.Controllers
{
    public class EmployeeController : Controller
    {
        public ActionResult NewEvaluation()
        {
            ViewBag.Message = Session["Username"] as string;
            return View();
        }

        [HttpPost]
        public ActionResult NewEvaluation(string Name, string Lastname, int Age, string Email, string Phone, string Address)
        {
            try
            {
                using (ERPEntities db = new ERPEntities())
                {
                    Evaluation oEvaluation = new Evaluation();
                    oEvaluation.id_us = int.Parse(Session["IdUser"] as string);
                    oEvaluation.name = Name.ToString();
                    oEvaluation.lastname = Lastname.ToString();
                    oEvaluation.age = Age;
                    oEvaluation.email= Email;
                    oEvaluation.phone = Phone;
                    oEvaluation.address = Address;
                    oEvaluation.answers = ",";
                    oEvaluation.result = "100";
                    oEvaluation.notes = "...";
                    db.Evaluation.Add(oEvaluation);
                    db.SaveChanges();
                }
                ViewBag.Success = "Empleado  guardado  correctamente";

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

        public ActionResult NewEmployee()
        {
            ViewBag.Message = Session["Username"] as string;
            List<SelectListItem> list = new List<SelectListItem>();
            using (Models.ERPEntities db= new Models.ERPEntities()) {
                list = (from d in db.Evaluation
                        select new SelectListItem() {
                            Value = d.id_evaluation.ToString(),
                            Text = d.lastname.ToString() + " " + d.name.ToString()
                         }).ToList();
            }
            return View(list);
        }

        [HttpPost]
        public ActionResult NewEmployee(int ddlEvaluacion, int idMoudle, string position, string pay, string workDays, int workHours)
        {
            try
            {
                using (ERPEntities db = new ERPEntities())
                {
                    Employee oEmployee= new Employee();
                    oEmployee.id_evaluation= ddlEvaluacion;
                    oEmployee.id_moudle=idMoudle;
                    oEmployee.position=position;
                    oEmployee.pay=pay;
                    oEmployee.work_days=workDays;
                    oEmployee.work_hours=workHours;
                    oEmployee.remaining_holidays = 0;
                    oEmployee.paid_holidays = 0;
                    db.Employee.Add(oEmployee);
                    db.SaveChanges();
                }
                ViewBag.Success = "Evaluacion  guardada  correctamente";

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
