using ERP.Models;
using ERP.Tools;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Net;
using System.Security.Policy;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace ERP.Controllers
{
    public class EmployeeController : Controller
    {
        public ActionResult NewEvaluation()
        {
            Session["Section"] = "-1";
            ViewBag.Message = Session["Username"] as string;
            return View(new Evaluation());
        }

        [HttpPost]
        public ActionResult NewEvaluation1(string Name, string Lastname, int Age, string Email, string Phone, string Address)
        {
            Evaluation oEvaluation = new Evaluation();
            try
            {
                oEvaluation.id_us = int.Parse(Session["IdUser"] as string);
                oEvaluation.name = Name.ToString();
                oEvaluation.lastname = Lastname.ToString();
                oEvaluation.age = Age;
                oEvaluation.email = Email;
                oEvaluation.phone = Phone;
                oEvaluation.address = Address;
                oEvaluation.answers = ",";
                oEvaluation.result = "100";
                oEvaluation.notes = "...";

                using (ERPEntities db = new ERPEntities())
                {
                    Evaluation eEvaluation = new Evaluation();
                    eEvaluation = (from d in db.Evaluation
                                   where d.email == Email.Trim() || d.phone == Phone.Trim()
                                   select d).FirstOrDefault();
                    if (eEvaluation != null)
                    {
                        ViewBag.Error = "Correo electronico o el numero de telefono ya registrados";
                        return View(oEvaluation);
                    }
                }

                using (ERPEntities db = new ERPEntities())
                {
                    db.Evaluation.Add(oEvaluation);
                    db.SaveChanges();
                }
                ViewBag.Success = "Empleado  guardado  correctamente";

                return View(new Evaluation());
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

                return View(oEvaluation);
            }
        }

        [HttpPost]
        public ActionResult AddQuestions(string Q1, string Q2, string Q3)
        {
            Session["Anwsers"] = (Session["Anwsers"] as string) + Q1 + ',' + Q2 + ',' + Q3 + ',';
            int section = int.Parse(Session["Section"] as string) + 1;
            Session["Section"] = section.ToString();
            if (section < 2) return View("NewEvaluation", new Evaluation() { id_evaluation = -1 });
            else return View("NewEvaluation", new Evaluation() { id_evaluation = -2 });
        }


        [HttpPost]
        public ActionResult AddEvaluation(string notes)
        {
            Evaluation oEvaluation = Session["Evaluation"] as Evaluation;
            string answers = Session["Anwsers"] as string;
            try
            {
                using (ERPEntities db = new ERPEntities())
                {
                    oEvaluation.answers = answers;
                    oEvaluation.notes = notes;
                    db.Evaluation.Add(oEvaluation);
                    db.SaveChanges();
                }
                ViewBag.Success = "Empleado  guardado  correctamente";

                return View("NewEvaluation", new Evaluation());
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

                return View("NewEvaluation", oEvaluation);
            }
        }

        [HttpPost]
        public ActionResult NewEvaluation(string Name, string Lastname, int Age, string Email, string Phone, string Address)
        {
            Evaluation oEvaluation = new Evaluation();
            oEvaluation.id_us = int.Parse(Session["IdUser"] as string);
            oEvaluation.name = Name.ToString();
            oEvaluation.lastname = Lastname.ToString();
            oEvaluation.age = Age;
            oEvaluation.email = Email;
            oEvaluation.phone = Phone;
            oEvaluation.address = Address;
            oEvaluation.answers = ",";
            oEvaluation.result = "100";
            oEvaluation.notes = "...";

            using (ERPEntities db = new ERPEntities())
            {
                Evaluation eEvaluation = new Evaluation();
                eEvaluation = (from d in db.Evaluation
                               where d.email == Email.Trim() || d.phone == Phone.Trim()
                               select d).FirstOrDefault();
                if (eEvaluation != null)
                {
                    ViewBag.Error = "Correo electronico o el numero de telefono ya registrados";
                    return View(oEvaluation);
                }
            }

            Session["Section"] = "0";
            Session["Evaluation"] = oEvaluation;
            Session["Anwsers"] = "";

            return View(new Evaluation() { id_evaluation = -1 });
        }

        

        public ActionResult NewEmployee()
        {
            ViewBag.Message = Session["Username"] as string;
            List<SelectListItem> list = new List<SelectListItem>();
            using (Models.ERPEntities db = new Models.ERPEntities())
            {
                list = (from d in db.Evaluation
                        select new SelectListItem()
                        {
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
