using ERP.Models;
using ERP.Tools;
using Microsoft.Ajax.Utilities;
using Rotativa;
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
        private static int page;
        private static string search;
        public ActionResult NewEvaluation()
        {
            Search.evaluation.id_evaluation = 0;
            Session["Section"] = "-1";
            return View(Search.evaluation);
        }
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

        public ActionResult Evaluations()
        {
            search = "";
            page = 0;
            return View(Search.Evaluations(search, page));
        }

        [HttpPost]
        public ActionResult Evaluations(string oSearch)
        {
            ViewBag.Volver = "Volver";
            search = oSearch;
            page = 0;
            return View(Search.Evaluations(search, page));
        }

        [HttpPost]
        public ActionResult AddQuestions(string Q1, string Q2, string Q3)
        {
            Session["Anwsers"] = (Session["Anwsers"] as string) + Q1 + ',' + Q2 + ',' + Q3 + ',';
            int section = int.Parse(Session["Section"] as string) + 1;
            Session["Section"] = section.ToString();
            if (section < 40) Search.evaluation.id_evaluation = -1; 
            else Search.evaluation.id_evaluation = -2;
            return View("NewEvaluation", Search.evaluation);
        }


        [HttpPost]
        public ActionResult AddEvaluation(string notes)
        {
            Evaluation oEvaluation = Session["Evaluation"] as Evaluation;
            string answers = Session["Anwsers"] as string;

            string[] answer = answers.Split(',');
            int[] numeros = { 0, 0, 0, 0, 0 };
            int[,] numeros2 = { { 0, 0, 0, 0, 0 , 0},
                                { 0, 0, 0, 0, 0 , 0},
                                { 0, 0, 0, 0, 0 , 0},
                                { 0, 0, 0, 0, 0 , 0},
                                { 0, 0, 0, 0, 0 , 0}};
            int round = -1;
            int total = 0;
            float promedio;
            for (int i = 0; i < answer.Length - 1; i++)
            {
                if (i % 5 == 0) round++;
                if (round == 6) round = 0;
                numeros[i % 5] += int.Parse(answer[i]);
                numeros2[i % 5, round] += int.Parse(answer[i]);
                total += int.Parse(answer[i]);
            }
            promedio = total / 6;

            string result = string.Format("{0}-" +
                "{1},{2},{3},{4},{5}-" +
                "{6},{7},{8},{9},{10},{11}|" +
                "{12},{13},{14},{15},{16},{17}|" +
                "{18},{19},{20},{21},{22},{23}|" +
                "{24},{25},{26},{26},{27},{28}|" +
                "{30},{31},{32},{33},{34},{35}", promedio,
                numeros[0], numeros[1], numeros[2], numeros[3], numeros[4],
                numeros2[0, 0], numeros2[0, 1], numeros2[0, 2], numeros2[0, 3], numeros2[0, 4], numeros2[0, 5],
                numeros2[1, 0], numeros2[1, 1], numeros2[1, 2], numeros2[1, 3], numeros2[1, 4], numeros2[1, 5],
                numeros2[2, 0], numeros2[2, 1], numeros2[2, 2], numeros2[2, 3], numeros2[2, 4], numeros2[2, 5],
                numeros2[3, 0], numeros2[3, 1], numeros2[3, 2], numeros2[3, 3], numeros2[3, 4], numeros2[3, 5],
                numeros2[4, 0], numeros2[4, 1], numeros2[4, 2], numeros2[4, 3], numeros2[4, 4], numeros2[4, 5]);

            try
            {
                using (ERPEntities db = new ERPEntities())
                {
                    oEvaluation.answers = answers;
                    oEvaluation.notes = notes;
                    oEvaluation.result = result;
                    oEvaluation.state = 0;
                    db.Evaluation.Add(oEvaluation);
                    db.SaveChanges();
                }
                ViewBag.Success = "Evaluación  guardada  correctamente";
                ViewBag.Report = "[Ver resultados]";

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
            oEvaluation.state = 0;

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

            Search.evaluation.id_evaluation = -1;
            return View(Search.evaluation);
        }

        public ActionResult NewEmployee(int id)
        {
            return View(Search.GetEvaluation(id));
        }

        [HttpPost]
        public ActionResult NewEmployee(int idEvaluacion, int idMoudle, string position, string pay, string workDays, int workHours)
        {
            try
            {
                using (ERPEntities db = new ERPEntities())
                {
                    Employee oEmployee= new Employee();
                    oEmployee.id_evaluation= idEvaluacion;
                    oEmployee.id_moudle=idMoudle;
                    oEmployee.position=position;
                    oEmployee.pay=pay;
                    oEmployee.work_days=workDays;
                    oEmployee.work_hours=workHours;
                    oEmployee.remaining_holidays = 0;
                    oEmployee.paid_holidays = 0;
                    db.Employee.Add(oEmployee);

                    Evaluation oEvaluation = db.Evaluation.Find(idEvaluacion);
                    oEvaluation.state = 1;
                    db.Entry(oEvaluation).State = System.Data.Entity.EntityState.Modified;

                    db.SaveChanges();
                }
                ViewBag.Success = "Empleado guardado correctamente";
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
            }
            return RedirectToAction("Evaluations");
        }
        public ActionResult StaffTracking(int id)
        {
            if (Search.StaffTrackings(id) == null) return View("Employee");
            return View(Search.employee);
        }

        public ActionResult NextEvaluation()
        {
            next();
            return View("Evaluations", Search.Evaluations(search, page));
        }
        public ActionResult PrevEvaluation()
        {
            prev();
            return View("Evaluations", Search.Evaluations(search, page));
        }

        public ActionResult NextEmployee()
        {
            next();
            return View("Employee", Search.Employees(search, page));
        }
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
