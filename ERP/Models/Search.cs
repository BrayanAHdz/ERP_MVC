using System.Collections.Generic;
using System.Linq;
using ERP.Models;
using ERP.Tools;
using Microsoft.Ajax.Utilities;
using System;
using System.Data.Entity.Validation;
using System.Net;
using System.Security.Policy;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace ERP.Models
{
    public static class Search
    {
        private static ERPEntities db;
        private static List<EmployeeList_Result> employeeList = new List<EmployeeList_Result>(11);
        private static List<EvaluationList_Result> evaluationList = new List<EvaluationList_Result>(11);
        private static List<AllEvaluationList_Result> allEvaluationList = new List<AllEvaluationList_Result>(11);
        private static List<UserList_Result> usersList = new List<UserList_Result>(11);

        public static vStaffTracking employee { get; set; } = new vStaffTracking();
        public static Evaluation evaluation { get; set; } = new Evaluation();

        public static List<EmployeeList_Result> Employees(string oSearch, int page)
        {
            using (db = new ERPEntities())
                employeeList = db.EmployeeList(oSearch, page * 10, page * 10 + 11).ToList();
            return employeeList;
        }

        public static List<UserList_Result> Users(string oSearch, int page)
        {
            using (db = new ERPEntities())
                usersList = db.UserList(oSearch, page * 10, page * 10 + 11).ToList();
            return usersList;
        }
        public static List<EvaluationList_Result> Evaluations(string oSearch, int page)
        {
            using (db = new ERPEntities())
                evaluationList = db.EvaluationList(oSearch, page * 10, page * 10 + 11).ToList();
            return evaluationList;
        }
        public static List<AllEvaluationList_Result> AllEvaluations(string oSearch, int page)
        {
            using (db = new ERPEntities())
                allEvaluationList = db.AllEvaluationList(oSearch, page * 10, page * 10 + 11).ToList();
            return allEvaluationList;
        }
        public static vStaffTracking StaffTrackings(int id)
        {
            using (db = new ERPEntities())
                employee = (from d in db.vStaffTracking
                            where d.id_employee == id
                            select d).FirstOrDefault();
            return employee;
        }

        public static Evaluation GetEvaluation(int id)
        {
            using (db = new ERPEntities())
                return db.Evaluation.Find(id);
        }
    }
}