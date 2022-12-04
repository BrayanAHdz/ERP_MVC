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
        public ActionResult Employee()
        {
            ViewBag.Message = Session["Username"] as string;
            List<vEmployee> list = new List<vEmployee>();
            using (ERPEntities db = new ERPEntities())
            {
                list = (from d in db.vEmployee
                        select d).ToList();
            }
            return View(list);
        }

        [HttpPost]
        public ActionResult Employee(string Search)
        {
            ViewBag.Message = Session["Username"] as string;
            List<vEmployee> list = new List<vEmployee>();
            using (ERPEntities db = new ERPEntities())
            {
                list = (from d in db.vEmployee
                        where d.fullname.Contains(Search) || d.module.Contains(Search) || d.position.Contains(Search)
                        select d).ToList();
            }
            return View(list);
        }

        [HttpPost]
        public ActionResult AddQuestions(string Q1, string Q2, string Q3)
        {
            Session["Anwsers"] = (Session["Anwsers"] as string) + Q1 + ',' + Q2 + ',' + Q3 + ',';
            int section = int.Parse(Session["Section"] as string) + 1;
            Session["Section"] = section.ToString();
            if (section < 40) return View("NewEvaluation", new Evaluation() { id_evaluation = -1 });
            else return View("NewEvaluation", new Evaluation() { id_evaluation = -2 });
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
            float promedio = 0f;
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

            return View(new Evaluation() { id_evaluation = -1 });
        }

        public ActionResult Evaluations()
        {
            ViewBag.Message = Session["Username"] as string;
            return View(vEvaSearch(""));
        }

        [HttpPost]
        public ActionResult Evaluations(string Search)
        {
            ViewBag.Message = Session["Username"] as string;
            ViewBag.Volver = "Volver";
            return View(vEvaSearch(Search));
        }

        public ActionResult NewEmployee(int id)
        {
            ViewBag.Message = Session["Username"] as string;
            Evaluation oEvaluation = new Evaluation();
            using (ERPEntities db = new ERPEntities())
            {
                oEvaluation = db.Evaluation.Find(id);
            }

            return View(oEvaluation);
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
                ViewBag.Success = "Evaluacion  guardada  correctamente";

                return View("Evaluations", vEvaSearch(""));
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

                return View("Evaluations", vEvaSearch(""));
            }
        }

        public ActionResult StaffTracking(int id)
        {
            ViewBag.Message = Session["Username"] as string;
            vStaffTracking employee = new vStaffTracking();
            using (ERPEntities db = new ERPEntities()) 
            {
                employee = (from d in db.vStaffTracking
                            where d.id_employee == id
                            select d).FirstOrDefault();
            }
            if (employee == null) return View("Employee");
            return View(employee);
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

        private List<vEvaluation> vEvaSearch(string Search)
        {
            List<vEvaluation> vEvaluationList = new List<vEvaluation>();
            using (ERPEntities db = new ERPEntities())
            {
                vEvaluationList = (from d in db.vEvaluation
                                   where (d.name.Contains(Search) || d.lastname.Contains(Search)) && d.state == 0
                                   select d).ToList();
            }
            return vEvaluationList;
        }
    }
}
