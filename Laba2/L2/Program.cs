using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace L2
{
    public class Employee
    {
        public String FullName { get; set; }
        public String Gender { get; set; }
        public String FamilyStatus { get; set; }
        public String HomeAddress { get; set; }
        public String Telephone { get; set; }
        public String Education { get; set; }
        public String DateOfReceipt { get; set; }
        public int DepartmentId { get; set; }
        public int PostId { get; set; }
        public Employee(String FullName, String Gender, String FamilyStatus,String HomeAddress, String Telephone, String Education, String DateOfReceipt, int DepartmentId, int PostId)
        {
            this.FullName = FullName;
            this.Gender = Gender;
            this.FamilyStatus = FamilyStatus;
            this.HomeAddress = HomeAddress;
            this.Telephone = Telephone;
            this.Education = Education;
            this.DateOfReceipt = DateOfReceipt;
            this.DepartmentId = DepartmentId;
            this.PostId = PostId;
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Write command getall/getwemp/insert/update/delete/function");
            //using (SqlConnection con = new SqlConnection("Data Source=.\\DESKTOP-AB1LV1R;Database=HumanResourcesDepartment;userid=Dasha;password=12345"))
            using (SqlConnection con = new SqlConnection("Persist Security Info=False;Integrated Security=true;Initial Catalog=HumanResourcesDepartment;server=(local)"))
            {
                con.Open();
                while (true)
                {
                    String statement = Console.ReadLine();
                    switch (statement)
                    {
                        case "insert":
                            Console.WriteLine("Insert procedure");
                            using (SqlCommand cmd = new SqlCommand("AddEmployee", con))
                            {
                                try
                                {
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    Console.WriteLine("\nEnter full name");
                                    cmd.Parameters.AddWithValue("@FullName", Console.ReadLine());
                                    Console.WriteLine("\nEnter gender");
                                    cmd.Parameters.AddWithValue("@Gender", Console.ReadLine());
                                    Console.WriteLine("\nEnter family status");
                                    cmd.Parameters.AddWithValue("@FamilyStatus", Console.ReadLine());
                                    Console.WriteLine("\nEnter home address");
                                    cmd.Parameters.AddWithValue("@HomeAddress", Console.ReadLine());
                                    Console.WriteLine("\nEnter telephone");
                                    cmd.Parameters.AddWithValue("@Telephone", Console.ReadLine());
                                    Console.WriteLine("\nEnter education");
                                    cmd.Parameters.AddWithValue("@Education", Console.ReadLine());
                                    Console.WriteLine("\nEnter date of receipt");
                                    cmd.Parameters.AddWithValue("@DateOfReceipt", Convert.ToDateTime(Console.ReadLine()));
                                    Console.WriteLine("\nEnter department ID");
                                    cmd.Parameters.AddWithValue("@DepartmentId", Convert.ToInt32(Console.ReadLine()));
                                    Console.WriteLine("\nEnter post ID");
                                    cmd.Parameters.AddWithValue("@PostId", Convert.ToInt32(Console.ReadLine()));
                                    cmd.ExecuteNonQuery();
                                    Console.WriteLine("Insert complete!");
                                }
                                catch (Exception e)
                                {
                                    Console.WriteLine("ERROR! " + e.Message);
                                }
                            }
                            break;
                        case "update":
                            Console.WriteLine("Update procedure");
                            using (SqlCommand cmd = new SqlCommand("UpdateEmployee", con))
                            {
                                try
                                {
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    Console.WriteLine("\nEnter id");
                                    cmd.Parameters.AddWithValue("@Id", Convert.ToInt64(Console.ReadLine()));
                                    Console.WriteLine("\nEnter full name");
                                    cmd.Parameters.AddWithValue("@FullName", Console.ReadLine());
                                    Console.WriteLine("\nEnter gender");
                                    cmd.Parameters.AddWithValue("@Gender", Console.ReadLine());
                                    Console.WriteLine("\nEnter family status");
                                    cmd.Parameters.AddWithValue("@FamilyStatus", Console.ReadLine());
                                    Console.WriteLine("\nEnter home address");
                                    cmd.Parameters.AddWithValue("@HomeAddress", Console.ReadLine());
                                    Console.WriteLine("\nEnter telephone");
                                    cmd.Parameters.AddWithValue("@Telephone", Console.ReadLine());
                                    Console.WriteLine("\nEnter education");
                                    cmd.Parameters.AddWithValue("@Education", Console.ReadLine());
                                    Console.WriteLine("\nEnter date of receipt");
                                    cmd.Parameters.AddWithValue("@DateOfReceipt", Convert.ToDateTime(Console.ReadLine()));
                                    Console.WriteLine("\nEnter department ID");
                                    cmd.Parameters.AddWithValue("@DepartmentId", Convert.ToInt32(Console.ReadLine()));
                                    Console.WriteLine("\nEnter post ID");
                                    cmd.Parameters.AddWithValue("@PostId", Convert.ToInt32(Console.ReadLine()));
                                    cmd.ExecuteNonQuery();
                                    Console.WriteLine("Update complete!");
                                }
                                catch (Exception e)
                                {
                                    Console.WriteLine("ERROR! " + e.Message);
                                }
                            }
                            break;
                        case "delete":
                            Console.WriteLine("Delete procedure");
                            using (SqlCommand cmd = new SqlCommand("DeleteEmployee", con))
                            {
                                try
                                {
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    Console.WriteLine("\nEnter id");
                                    cmd.Parameters.AddWithValue("@Id", Convert.ToInt64(Console.ReadLine()));
                                    cmd.ExecuteNonQuery();
                                    Console.WriteLine("Delete complete!");
                                }
                                catch (Exception e)
                                {
                                    Console.WriteLine("ERROR! " + e.Message);
                                }
                            }
                            break;
                        case "getall":
                            Console.WriteLine("Select all employees");
                            using (SqlCommand cmd = new SqlCommand("GetAllEmp", con))
                            {
                                try
                                {
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    SqlDataReader reader = cmd.ExecuteReader();
                                    List<Employee> employee = new List<Employee>();
                                    while (reader.Read())
                                    {
                                        Employee emp = new Employee(Convert.ToString(reader[0]), Convert.ToString(reader[1]),
                                            Convert.ToString(reader[2]), Convert.ToString(reader[3]), Convert.ToString(reader[4]), 
                                            Convert.ToString(reader[5]), Convert.ToString(reader[6]), Convert.ToInt32(reader[7]), Convert.ToInt32(reader[8]));
                                        employee.Add(emp);
                                    }
                                    foreach (Employee emp in employee)
                                    {
                                        Console.WriteLine(emp.FullName + ", " + emp.Gender + ", " + emp.FamilyStatus + ", " + emp.Education + ", " + emp.HomeAddress + ", " + emp.Telephone + ", " + emp.DateOfReceipt + ", " + emp.DepartmentId + ", " + emp.PostId);
                                    }
                                    reader.Close();
                                }
                                catch (Exception e)
                                {
                                    Console.WriteLine("ERROR! " + e.Message);
                                }
                            }
                            break;
                        case "getwemp":
                            Console.WriteLine("Select employees that work now");
                            using (SqlCommand cmd = new SqlCommand("GetWorksEmployees", con))
                            {
                                try
                                {
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    SqlDataReader reader = cmd.ExecuteReader();
                                    List<Employee> employee = new List<Employee>();
                                    while (reader.Read())
                                    {
                                        Employee emp = new Employee(Convert.ToString(reader[0]), Convert.ToString(reader[1]),
                                             Convert.ToString(reader[2]), Convert.ToString(reader[3]), Convert.ToString(reader[4]),
                                             Convert.ToString(reader[5]), Convert.ToString(reader[6]), Convert.ToInt32(reader[7]), Convert.ToInt32(reader[8]));
                                        employee.Add(emp);
                                    }
                                    foreach (Employee emp in employee)
                                    {
                                        Console.WriteLine(emp.FullName + ", " + emp.Gender + ", " + emp.FamilyStatus + ", " + emp.Education + ", " + emp.HomeAddress + ", " + emp.Telephone + ", " + emp.DateOfReceipt + ", " + emp.DepartmentId + ", " + emp.PostId);
                                    }
                                    reader.Close();
                                }
                                catch (Exception e)
                                {
                                    Console.WriteLine("ERROR! " + e.Message);
                                }
                            }
                            break;
                        case "function":
                            Console.WriteLine("Function check Id of employee is valid or not");
                            using (SqlCommand cmd = new SqlCommand("IsValidId", con))
                            {
                                try
                                {
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    Console.WriteLine("\nEnter id");
                                    cmd.Parameters.AddWithValue("@Id", Convert.ToInt64(Console.ReadLine()));
                                    SqlParameter returnValue = cmd.Parameters.Add("@res", SqlDbType.VarChar);
                                    returnValue.Direction = ParameterDirection.ReturnValue;
                                    cmd.ExecuteNonQuery();
                                    Console.WriteLine(returnValue.Value);
                                }
                                catch (Exception e)
                                {
                                    Console.WriteLine("ERROR! " + e.Message);
                                }

                            }
                            break;
                        default:
                            Console.WriteLine("Enter correct statement");
                            break;
                    }
                }
            }
        }
    }
}